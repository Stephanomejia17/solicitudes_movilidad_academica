import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:solicitudes_movilidad_academica/data/app_database.dart';

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
  });
}

Future<UsuarioData> _createStudent(AppDatabase db) async {
  final now = DateTime(2026, 1, 1);
  await db.upsertUsuarioLocal(
    id: 'student-1',
    nombre: 'Laura',
    apellido: 'Gomez',
    email: 'laura.gomez@udem.edu.co',
    rol: 'estudiante',
    estado: 'activo',
    createdAt: now,
    updatedAt: now,
    pendingSync: false,
  );

  return (await db.getUsuarioById('student-1'))!;
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
