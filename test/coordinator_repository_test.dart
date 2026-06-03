import 'package:drift/drift.dart' hide isNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:solicitudes_movilidad_academica/data/app_database.dart';
import 'package:solicitudes_movilidad_academica/features/coordinator/domain/coordinator_validators.dart';
import 'package:solicitudes_movilidad_academica/features/coordinator/services/coordinator_firestore_service.dart';
import 'package:solicitudes_movilidad_academica/features/coordinator/services/coordinator_repository.dart';
import 'package:solicitudes_movilidad_academica/shared/models/models.dart';

// Fake del servicio remoto de firebase para verificar llamadas

class FakeCoordinatorFirestoreService implements CoordinatorFirestoreService {
  FakeCoordinatorFirestoreService({
    this.shouldThrowOnUpsert = false,
    this.shouldThrowOnFetch = false,
    this.remoteSolicitudes = const [],
  });

  final bool shouldThrowOnUpsert;
  final bool shouldThrowOnFetch;
  final List<SolicitudMovilidadModel> remoteSolicitudes;

  final List<SolicitudMovilidadModel> solicitudesUpserted = [];
  final List<AprobacionModel> aprobacionesUpserted = [];

  @override
  Future<void> upsertSolicitudBundle({
    required SolicitudMovilidadModel solicitud,
    required List<AprobacionModel> aprobaciones,
  }) async {
    if (shouldThrowOnUpsert) throw Exception('remote error');
    solicitudesUpserted.add(solicitud);
    aprobacionesUpserted.addAll(aprobaciones);
  }

  @override
  Future<List<SolicitudMovilidadModel>> fetchSolicitudes() async {
    if (shouldThrowOnFetch) throw Exception('offline');
    return remoteSolicitudes;
  }

  @override
  Future<SolicitudMovilidadModel?> fetchSolicitud(String id) async {
    if (shouldThrowOnFetch) throw Exception('offline');
    return remoteSolicitudes.where((s) => s.id == id).firstOrNull;
  }

  @override
  Future<List<AprobacionModel>> fetchAprobaciones(String solicitudId) async {
    return [];
  }
}


void main() {
  group('CoordinatorReviewPolicy', () {
    late CoordinatorReviewPolicy policy;

    setUp(() {
      policy = const CoordinatorReviewPolicy();
    });

    test('canReview retorna true si el actor es coordinador activo y la solicitud esta enviada', () {
      expect(policy.canReview(_coordinator(), _solicitudEnviada()), isTrue);
    });

    test('canReview retorna false si el rol no es coordinador', () {
      expect(policy.canReview(_coordinator(rol: 'estudiante'), _solicitudEnviada()), isFalse);
    });

    test('canReview retorna false si el estado del actor no es activo', () {
      expect(policy.canReview(_coordinator(estado: 'inactivo'), _solicitudEnviada()), isFalse);
    });

    test('canReview retorna false si la solicitud no esta en estado enviada', () {
      expect(policy.canReview(_coordinator(), _solicitudEnviada(estado: 'borrador')), isFalse);
      expect(policy.canReview(_coordinator(), _solicitudEnviada(estado: 'aprobada')), isFalse);
      expect(policy.canReview(_coordinator(), _solicitudEnviada(estado: 'rechazada')), isFalse);
    });

    test('ensureCanApprove lanza StateError si el actor no puede revisar', () {
      expect(
        () => policy.ensureCanApprove(_coordinator(rol: 'estudiante'), _solicitudEnviada()),
        throwsA(isA<StateError>()),
      );
    });

    test('ensureCanReject lanza StateError si el actor no puede revisar', () {
      expect(
        () => policy.ensureCanReject(
          _coordinator(rol: 'estudiante'),
          _solicitudEnviada(),
          motivo: 'No aplica',
        ),
        throwsA(isA<StateError>()),
      );
    });

    test('ensureCanReject lanza ArgumentError si el motivo esta vacio o solo espacios', () {
      expect(
        () => policy.ensureCanReject(_coordinator(), _solicitudEnviada(), motivo: ''),
        throwsA(isA<ArgumentError>()),
      );
      expect(
        () => policy.ensureCanReject(_coordinator(), _solicitudEnviada(), motivo: '   '),
        throwsA(isA<ArgumentError>()),
      );
    });
  });

  group('CoordinatorRepository', () {
    late AppDatabase db;
    late FakeCoordinatorFirestoreService remote;
    late CoordinatorRepository repository;

    setUp(() async {
      db = AppDatabase(NativeDatabase.memory());
      remote = FakeCoordinatorFirestoreService();
      repository = CoordinatorRepository(database: db, remote: remote);
    });

    tearDown(() async {
      await db.close();
    });

    group('watchCounts', () {
      test('emite conteos correctos dado una lista de solicitudes con estados mixtos', () async {
        final coordinator = await _insertCoordinator(db);
        await _insertSolicitud(db, coordinator.id, estado: 'enviada', solicitudId: 's-1');
        await _insertSolicitud(db, coordinator.id, estado: 'enviada', solicitudId: 's-2');
        await _insertSolicitud(db, coordinator.id, estado: 'aprobada', solicitudId: 's-3');
        await _insertSolicitud(db, coordinator.id, estado: 'rechazada', solicitudId: 's-4');

        final counts = await repository.watchCounts().first;

        expect(counts.total, 4);
        expect(counts.pending, 2);
        expect(counts.approved, 1);
        expect(counts.rejected, 1);
      });
    });

    group('watchSolicitud', () {
      test('retorna el item correcto por id', () async {
        final coordinator = await _insertCoordinator(db);
        await _insertSolicitud(db, coordinator.id, estado: 'enviada', solicitudId: 's-1');
        await _insertSolicitud(db, coordinator.id, estado: 'aprobada', solicitudId: 's-2');

        final found = await repository.watchSolicitud('s-2').first;

        expect(found?.id, 's-2');
        expect(found?.estado, 'aprobada');
      });

      test('retorna null si el id no existe', () async {
        final missing = await repository.watchSolicitud('no-existe').first;
        expect(missing, isNull);
      });
    });

    group('approve', () {
      test('lanza StateError si la solicitud no existe en la base local', () async {
        final coordinator = await _insertCoordinator(db);

        await expectLater(
          repository.approve(actor: coordinator, solicitudId: 'no-existe'),
          throwsA(isA<StateError>()),
        );
      });

      test('lanza StateError si el actor no es coordinador activo', () async {
        final student = await _insertCoordinator(db, rol: 'estudiante', id: 'est-1');
        await _insertSolicitud(db, student.id, estado: 'enviada', solicitudId: 's-1');

        await expectLater(
          repository.approve(actor: student, solicitudId: 's-1'),
          throwsA(isA<StateError>()),
        );
      });

      test('persiste Aprobacion con decision aprobada y cambia estado de la solicitud', () async {
        final coordinator = await _insertCoordinator(db);
        await _insertSolicitud(db, coordinator.id, estado: 'enviada', solicitudId: 's-1');

        await repository.approve(
          actor: coordinator,
          solicitudId: 's-1',
          comentario: 'Todo correcto',
        );

        final solicitud = await db.getSolicitudById('s-1');
        final aprobaciones = await db.getAprobacionesDeSolicitud('s-1');

        expect(solicitud?.estado, 'aprobada');
        expect(solicitud?.bloqueada, isTrue);
        expect(aprobaciones, hasLength(1));
        expect(aprobaciones.single.decision, 'aprobada');
        expect(aprobaciones.single.comentario, 'Todo correcto');
      });

      test('llama a upsertSolicitudBundle en el remote', () async {
        final coordinator = await _insertCoordinator(db);
        await _insertSolicitud(db, coordinator.id, estado: 'enviada', solicitudId: 's-1');

        await repository.approve(actor: coordinator, solicitudId: 's-1');

        expect(remote.solicitudesUpserted, hasLength(1));
        expect(remote.solicitudesUpserted.single.id, 's-1');
      });

      test('usa comentario por defecto si el comentario esta vacio', () async {
        final coordinator = await _insertCoordinator(db);
        await _insertSolicitud(db, coordinator.id, estado: 'enviada', solicitudId: 's-1');

        await repository.approve(actor: coordinator, solicitudId: 's-1', comentario: '');

        final aprobaciones = await db.getAprobacionesDeSolicitud('s-1');
        expect(aprobaciones.single.comentario, 'Solicitud aprobada por el coordinador.');
      });
    });

    group('reject', () {
      test('lanza StateError si la solicitud no existe', () async {
        final coordinator = await _insertCoordinator(db);

        await expectLater(
          repository.reject(
            actor: coordinator,
            solicitudId: 'no-existe',
            motivo: 'No aplica',
          ),
          throwsA(isA<StateError>()),
        );
      });

      test('lanza ArgumentError si el motivo esta vacio', () async {
        final coordinator = await _insertCoordinator(db);
        await _insertSolicitud(db, coordinator.id, estado: 'enviada', solicitudId: 's-1');

        await expectLater(
          repository.reject(actor: coordinator, solicitudId: 's-1', motivo: '   '),
          throwsA(isA<ArgumentError>()),
        );
      });

      test('persiste Aprobacion con decision rechazada y cambia estado de la solicitud', () async {
        final coordinator = await _insertCoordinator(db);
        await _insertSolicitud(db, coordinator.id, estado: 'enviada', solicitudId: 's-1');

        await repository.reject(
          actor: coordinator,
          solicitudId: 's-1',
          motivo: 'No cumple requisitos',
        );

        final solicitud = await db.getSolicitudById('s-1');
        final aprobaciones = await db.getAprobacionesDeSolicitud('s-1');

        expect(solicitud?.estado, 'rechazada');
        expect(solicitud?.bloqueada, isTrue);
        expect(aprobaciones, hasLength(1));
        expect(aprobaciones.single.decision, 'rechazada');
        expect(aprobaciones.single.comentario, 'No cumple requisitos');
      });

      test('llama a upsertSolicitudBundle en el remote', () async {
        final coordinator = await _insertCoordinator(db);
        await _insertSolicitud(db, coordinator.id, estado: 'enviada', solicitudId: 's-1');

        await repository.reject(
          actor: coordinator,
          solicitudId: 's-1',
          motivo: 'Documentos incompletos',
        );

        expect(remote.solicitudesUpserted, hasLength(1));
        expect(remote.solicitudesUpserted.single.id, 's-1');
      });
    });

    group('syncPending', () {
      test('llama a upsertSolicitudBundle por cada solicitud con pendingSync=true', () async {
        final coordinator = await _insertCoordinator(db);
        await _insertSolicitud(db, coordinator.id, estado: 'aprobada', solicitudId: 's-1', pendingSync: true);
        await _insertSolicitud(db, coordinator.id, estado: 'rechazada', solicitudId: 's-2', pendingSync: true);

        await repository.syncPending();

        expect(remote.solicitudesUpserted.map((s) => s.id), containsAll(['s-1', 's-2']));
      });

      test('no lanza si el remote falla offline-first', () async {
        final coordinator = await _insertCoordinator(db);
        await _insertSolicitud(db, coordinator.id, estado: 'enviada', solicitudId: 's-1', pendingSync: true);

        final remoteQueThrow = FakeCoordinatorFirestoreService(shouldThrowOnUpsert: true);
        final repoOffline = CoordinatorRepository(database: db, remote: remoteQueThrow);

        await expectLater(repoOffline.syncPending(), completes);
      });
    });
    }); 
}


// Helpers

UsuarioData _coordinator({
  String rol = 'coordinador',
  String estado = 'activo',
}) {
  final now = DateTime(2026, 1, 1);
  return UsuarioData(
    id: 'coord-1',
    nombre: 'Carla',
    apellido: 'Rojas',
    email: 'carla.rojas@udem.edu.co',
    rol: rol,
    estado: estado,
    createdAt: now,
    updatedAt: now,
    pendingSync: false,
  );
}

SolicitudMobilidadData _solicitudEnviada({String estado = 'enviada'}) {
  final now = DateTime(2026, 1, 1);
  return SolicitudMobilidadData(
    id: 's-1',
    estudianteId: 'student-1',
    tipoMovilidad: 'internacional',
    nombres: 'Laura',
    apellidos: 'Gomez',
    tipoDocumento: 'CC',
    numeroDocumento: '123456789',
    fechaNacimiento: DateTime(2002, 5, 10),
    emailInstitucional: 'laura.gomez@udem.edu.co',
    emailPersonal: 'laura.personal@example.com',
    telefono: '3001234567',
    contactoEmergencia: 'Ana Gomez',
    relacionContacto: 'Madre',
    universidadActual: 'Universidad de Medellin',
    facultad: 'Ingenierias',
    universidadDestinoId: 'uv-1',
    universidadDestinoNombre: 'Universidad de Valencia',
    paisDestino: 'Espana',
    ciudadDestino: 'Valencia',
    facultadDestino: 'Ingenieria',
    areaEstudio: 'Software',
    programaAcademico: 'Ingenieria de Sistemas',
    semestre: 7,
    promedioAcumulado: 4.3,
    nivelIdioma: 'B2',
    puntajeIdioma: '85',
    semestreIntercambio: '2026-2',
    fechaViaje: DateTime(2026, 8, 1),
    fechaRegreso: DateTime(2026, 12, 15),
    estado: estado,
    bloqueada: false,
    fechaCreacion: now,
    fechaActualizacion: now,
    pendingSync: false,
  );
}

Future<UsuarioData> _insertCoordinator(
  AppDatabase db, {
  String id = 'coord-1',
  String rol = 'coordinador',
  String estado = 'activo',
}) async {
  final now = DateTime(2026, 1, 1);
  await db.upsertUsuarioLocal(
    id: id,
    nombre: 'Carla',
    apellido: 'Rojas',
    email: 'carla.rojas@udem.edu.co',
    rol: rol,
    estado: estado,
    createdAt: now,
    updatedAt: now,
    pendingSync: false,
  );
  return (await db.getUsuarioById(id))!;
}

Future<void> _insertSolicitud(
  AppDatabase db,
  String estudianteId, {
  required String estado,
  required String solicitudId,
  bool pendingSync = false,
}) async {
  final now = DateTime(2026, 1, 1);
  await db.into(db.solicitudMovilidad).insertOnConflictUpdate(
    SolicitudMovilidadCompanion.insert(
      id: solicitudId,
      estudianteId: estudianteId,
      tipoMovilidad: 'internacional',
      nombres: const Value('Laura'),
      apellidos: const Value('Gomez'),
      tipoDocumento: const Value('CC'),
      numeroDocumento: const Value('123456789'),
      fechaNacimiento: DateTime(2002, 5, 10),
      emailInstitucional: 'laura.gomez@udem.edu.co',
      emailPersonal: 'laura.personal@example.com',
      telefono: '3001234567',
      contactoEmergencia: 'Ana Gomez',
      relacionContacto: 'Madre',
      universidadActual: const Value('Universidad de Medellin'),
      facultad: const Value('Ingenierias'),
      universidadDestinoId: 'uv-1',
      universidadDestinoNombre: const Value('Universidad de Valencia'),
      paisDestino: const Value('Espana'),
      ciudadDestino: const Value('Valencia'),
      facultadDestino: const Value('Ingenieria'),
      areaEstudio: const Value('Software'),
      programaAcademico: 'Ingenieria de Sistemas',
      semestre: 7,
      promedioAcumulado: const Value(4.3),
      nivelIdioma: const Value('B2'),
      puntajeIdioma: const Value('85'),
      semestreIntercambio: const Value('2026-2'),
      fechaViaje: Value(DateTime(2026, 8, 1)),
      fechaRegreso: Value(DateTime(2026, 12, 15)),
      estado: Value(estado),
      bloqueada: const Value(false),
      fechaCreacion: now,
      fechaActualizacion: now,
      pendingSync: Value(pendingSync),
    ),
  );
}