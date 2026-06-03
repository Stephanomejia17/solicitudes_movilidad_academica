import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:solicitudes_movilidad_academica/data/app_database.dart';
import 'package:solicitudes_movilidad_academica/features/student/widgets/student_dashboard_widgets.dart';

void main() {
  late AppDatabase db;
  late UsuarioData student;
  late SolicitudMobilidadData solicitud;

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    student = await _createStudent(db);
    solicitud = await _createSolicitud(db, student);
  });

  tearDown(() async {
    await db.close();
  });

  testWidgets('WelcomeBanner muestra accion para crear solicitud', (
    tester,
  ) async {
    var tapped = false;

    await tester.pumpWidget(
      _wrap(WelcomeBanner(user: student, onCreateRequest: () => tapped = true)),
    );

    expect(find.text('Hola, Laura'), findsOneWidget);
    expect(find.text('Nueva solicitud'), findsOneWidget);

    await tester.tap(find.text('Nueva solicitud'));
    expect(tapped, isTrue);
  });

  testWidgets('RequestSummaryCard refleja estado offline-first pendiente', (
    tester,
  ) async {
    await tester.pumpWidget(_wrap(RequestSummaryCard(solicitud: solicitud)));

    expect(find.text('Universidad de Valencia'), findsOneWidget);
    expect(find.text('Borrador'), findsOneWidget);
    expect(find.text('Pendiente de sincronizar'), findsOneWidget);
    expect(find.byIcon(Icons.cloud_off_outlined), findsOneWidget);
  });

  testWidgets('DetailSection renderiza filas de informacion del estudiante', (
    tester,
  ) async {
    await tester.pumpWidget(
      _wrap(
        DetailSection(
          title: 'Informacion academica',
          rows: [
            detailRow('Programa', solicitud.programaAcademico),
            detailRow('Semestre', solicitud.semestre.toString()),
          ],
        ),
      ),
    );

    expect(find.text('Informacion academica'), findsOneWidget);
    expect(find.text('Programa'), findsOneWidget);
    expect(find.text('Ingenieria de Sistemas'), findsOneWidget);
    expect(find.text('Semestre'), findsOneWidget);
    expect(find.text('7'), findsOneWidget);
  });
}

Widget _wrap(Widget child) {
  return MaterialApp(home: Scaffold(body: child));
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

Future<SolicitudMobilidadData> _createSolicitud(
  AppDatabase db,
  UsuarioData student,
) async {
  final id = await db.crearSolicitud(
    SolicitudMovilidadCompanion.insert(
      id: '',
      estudianteId: student.id,
      tipoMovilidad: 'internacional',
      fechaNacimiento: DateTime(2002, 5, 10),
      emailInstitucional: 'laura.gomez@udem.edu.co',
      emailPersonal: 'laura.personal@example.com',
      telefono: '3001234567',
      contactoEmergencia: 'Ana Gomez',
      relacionContacto: 'Madre',
      universidadDestinoId: 'uv-1',
      programaAcademico: 'Ingenieria de Sistemas',
      semestre: 7,
      fechaCreacion: DateTime(2026, 1, 1),
      fechaActualizacion: DateTime(2026, 1, 1),
      nombres: const Value('Laura'),
      apellidos: const Value('Gomez'),
      universidadDestinoNombre: const Value('Universidad de Valencia'),
      paisDestino: const Value('España'),
      ciudadDestino: const Value('Valencia'),
      promedioAcumulado: const Value(4.3),
    ),
  );

  return (await db.getSolicitudById(id))!;
}
