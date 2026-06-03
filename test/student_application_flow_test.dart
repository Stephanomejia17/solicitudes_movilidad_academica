import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:solicitudes_movilidad_academica/data/app_database.dart';
import 'package:solicitudes_movilidad_academica/features/student/services/student_application_repository.dart';
import 'package:solicitudes_movilidad_academica/features/student/services/student_firestore_service.dart';
import 'package:solicitudes_movilidad_academica/shared/models/models.dart';

void main() {
  late AppDatabase db;
  late UsuarioData student;

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    student = await _createStudent(db);
  });

  tearDown(() async {
    await db.close();
  });

  test('no permite enviar una solicitud sin documentos requeridos', () async {
    final solicitudId = await _createDraft(db, student);

    await expectLater(
      db.enviarSolicitud(solicitudId, student, const []),
      throwsA(isA<StateError>()),
    );

    final solicitud = await db.getSolicitudById(solicitudId);
    final history = await db.getHistorialDeSolicitud(solicitudId);

    expect(solicitud?.estado, 'borrador');
    expect(solicitud?.bloqueada, isFalse);
    expect(history, isEmpty);
  });

  test('solo un estudiante activo puede enviar la solicitud', () async {
    final solicitudId = await _createDraft(db, student);
    await _addRequiredDocuments(db, solicitudId);
    final coordinator = await _createUser(
      db,
      id: 'coordinator-1',
      rol: 'coordinador',
    );

    await expectLater(
      db.enviarSolicitud(
        solicitudId,
        coordinator,
        await db.getDocumentosDeSolicitud(solicitudId),
      ),
      throwsA(isA<StateError>()),
    );

    final solicitud = await db.getSolicitudById(solicitudId);
    expect(solicitud?.estado, 'borrador');
    expect(solicitud?.bloqueada, isFalse);
  });

  test('no permite documentos requeridos duplicados', () async {
    final solicitudId = await _createDraft(db, student);
    final repository = StudentApplicationRepository(
      database: db,
      remote: _NoopStudentFirestoreService(),
    );

    await repository.addDocument(
      solicitudId: solicitudId,
      tipoDocumento: 'carta_motivacion',
      nombreArchivo: ' carta_motivacion.pdf ',
    );

    await expectLater(
      repository.addDocument(
        solicitudId: solicitudId,
        tipoDocumento: 'carta_motivacion',
        nombreArchivo: 'otra_carta.pdf',
      ),
      throwsA(isA<StateError>()),
    );

    final documentos = await db.getDocumentosDeSolicitud(solicitudId);
    expect(documentos, hasLength(1));
    expect(documentos.single.nombreArchivo, 'carta_motivacion.pdf');
  });

  test('envia, bloquea e historiza una solicitud con soportes', () async {
    final solicitudId = await _createDraft(db, student);
    await _addRequiredDocuments(db, solicitudId);

    await db.enviarSolicitud(
      solicitudId,
      student,
      await db.getDocumentosDeSolicitud(solicitudId),
    );

    final solicitud = await db.getSolicitudById(solicitudId);
    final history = await db.getHistorialDeSolicitud(solicitudId);

    expect(solicitud?.estado, 'enviada');
    expect(solicitud?.bloqueada, isTrue);
    expect(history, hasLength(1));
    expect(history.single.estadoAnterior, 'borrador');
    expect(history.single.estadoNuevo, 'enviada');

    await expectLater(
      db.actualizarSolicitud(
        SolicitudMovilidadCompanion(
          id: Value(solicitudId),
          programaAcademico: const Value('Ingenieria Ambiental'),
        ),
      ),
      throwsA(isA<StateError>()),
    );

    await expectLater(
      db.eliminarSolicitud(solicitudId),
      throwsA(isA<StateError>()),
    );
  });
}

class _NoopStudentFirestoreService implements StudentFirestoreService {
  @override
  Future<void> upsertSolicitud(SolicitudMobilidadData solicitud) async {}

  @override
  Future<void> upsertSolicitudBundle({
    required SolicitudMobilidadData solicitud,
    required List<DocumentoData> documentos,
  }) async {}

  @override
  Future<void> deleteDocumentosAusentes({
    required String solicitudId,
    required Set<String> localDocumentoIds,
  }) async {}

  @override
  Future<void> deleteSolicitud(String id) async {}

  @override
  Future<List<SolicitudMovilidadModel>> fetchSolicitudesDeEstudiante(
    String estudianteId,
    String email,
  ) async {
    return const [];
  }

  @override
  Future<List<DocumentoModel>> fetchDocumentos(String solicitudId) async {
    return const [];
  }
}

Future<UsuarioData> _createStudent(AppDatabase db) async {
  return _createUser(db, id: 'student-1', rol: 'estudiante');
}

Future<UsuarioData> _createUser(
  AppDatabase db, {
  required String id,
  required String rol,
}) async {
  final now = DateTime(2026, 1, 1);
  await db.upsertUsuarioLocal(
    id: id,
    nombre: 'Laura',
    apellido: 'Gomez',
    email: '$id@udem.edu.co',
    rol: rol,
    estado: 'activo',
    createdAt: now,
    updatedAt: now,
    pendingSync: false,
  );

  return (await db.getUsuarioById(id))!;
}

Future<String> _createDraft(AppDatabase db, UsuarioData student) {
  return db.crearSolicitud(
    SolicitudMovilidadCompanion.insert(
      id: '',
      estudianteId: student.id,
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
      paisDestino: const Value('España'),
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
      fechaCreacion: DateTime(2026, 1, 1),
      fechaActualizacion: DateTime(2026, 1, 1),
    ),
  );
}

Future<void> _addRequiredDocuments(AppDatabase db, String solicitudId) async {
  await db.insertarDocumento(
    DocumentoCompanion.insert(
      id: '',
      solicitudId: solicitudId,
      tipoDocumento: 'carta_motivacion',
      nombreArchivo: 'carta_motivacion.pdf',
      fechaSubida: DateTime(2026, 1, 2),
    ),
  );
  await db.insertarDocumento(
    DocumentoCompanion.insert(
      id: '',
      solicitudId: solicitudId,
      tipoDocumento: 'documento_identidad',
      nombreArchivo: 'cedula.pdf',
      fechaSubida: DateTime(2026, 1, 2),
    ),
  );
}
