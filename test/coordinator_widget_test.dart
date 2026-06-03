import 'dart:async';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:solicitudes_movilidad_academica/data/app_database.dart';
import 'package:solicitudes_movilidad_academica/features/auth/services/auth_service.dart';
import 'package:solicitudes_movilidad_academica/features/coordinator/pages/coordinator_dashboard_page.dart';
import 'package:solicitudes_movilidad_academica/features/coordinator/pages/coordinator_solicitud_detail_page.dart';
import 'package:solicitudes_movilidad_academica/features/coordinator/services/coordinator_repository.dart';

class MockCoordinatorRepository extends Mock implements CoordinatorRepository {}

class MockAuthService extends Mock implements AuthService {}

void main() {
  late MockCoordinatorRepository repository;
  late MockAuthService authService;

  setUp(() {
    repository = MockCoordinatorRepository();
    authService = MockAuthService();

    when(() => repository.syncPending()).thenAnswer((_) async {});
    when(() => authService.logout()).thenAnswer((_) async {});
  });

  group('CoordinatorDashboardPage', () {
    testWidgets('muestra CircularProgressIndicator mientras el stream no tiene datos', (tester) async {
      final controller = StreamController<List<SolicitudMobilidadData>>();
      when(() => repository.watchSolicitudes()).thenAnswer((_) => controller.stream);

      await tester.pumpWidget(
        MaterialApp(
          home: CoordinatorDashboardPage(
            repository: repository,
            authService: authService,
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      await controller.close();
    });


    testWidgets('muestra el texto vacío correcto cuando una tab no tiene items', (tester) async {
      when(() => repository.watchSolicitudes()).thenAnswer(
        (_) => Stream.value([]),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: CoordinatorDashboardPage(
            repository: repository,
            authService: authService,
          ),
        ),
      );

      await tester.pumpAndSettle();
      
      await tester.tap(find.text(' En revision'));
      await tester.pumpAndSettle();
      expect(find.text('No hay solicitudes pendientes de revision.'), findsOneWidget);

      await tester.tap(find.text(' Aprobadas'));
      await tester.pumpAndSettle();
      expect(find.text('No hay solicitudes aprobadas todavia.'), findsOneWidget);

      await tester.tap(find.text(' Rechazadas'));
      await tester.pumpAndSettle();
      expect(find.text('No hay solicitudes rechazadas todavia.'), findsOneWidget);
    });

    testWidgets('al tap en una solicitud navega a CoordinatorSolicitudDetailPage', (tester) async {
      final db = AppDatabase(NativeDatabase.memory());
      addTearDown(db.close);
      await _setCurrentUser(db);

      when(() => repository.watchSolicitudes()).thenAnswer(
        (_) => Stream.value([
          _solicitud(id: 's-1', estado: 'enviada'),
        ]),
      );
      when(() => repository.watchSolicitud('s-1')).thenAnswer(
        (_) => Stream.value(_solicitud(id: 's-1', estado: 'enviada')),
      );
      when(() => repository.watchAprobaciones('s-1')).thenAnswer(
        (_) => Stream.value(const <AprobacionData>[]),
      );

      await tester.pumpWidget(
        AppStateScope(
          state: db,
          child: MaterialApp(
            home: CoordinatorDashboardPage(
              repository: repository,
              authService: authService,
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();
      await tester.tap(find.byType(ListTile).first);
      await tester.pumpAndSettle();

      expect(find.text('Detalle de solicitud'), findsOneWidget);

    });

    testWidgets('el botón de sync llama a repository.syncPending()', (tester) async {
      when(() => repository.watchSolicitudes()).thenAnswer(
        (_) => Stream.value(const <SolicitudMobilidadData>[]),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: CoordinatorDashboardPage(
            repository: repository,
            authService: authService,
          ),
        ),
      );

      await tester.pumpAndSettle();
      await tester.tap(find.byTooltip('Sincronizar'));
      await tester.pumpAndSettle();

      verify(() => repository.syncPending()).called(2);
    });

    testWidgets('el botón de logout llama a authService.logout()', (tester) async {
      when(() => repository.watchSolicitudes()).thenAnswer(
        (_) => Stream.value(const <SolicitudMobilidadData>[]),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: CoordinatorDashboardPage(
            repository: repository,
            authService: authService,
          ),
        ),
      );

      await tester.pumpAndSettle();
      await tester.tap(find.byTooltip('Cerrar sesion'));
      await tester.pumpAndSettle();

      verify(() => authService.logout()).called(1);
    });
  });

  group('CoordinatorSolicitudDetailPage', () {
    late UsuarioData coordinator;

    setUp(() {
      coordinator = _usuario();
    });

    testWidgets('muestra CircularProgressIndicator mientras carga', (tester) async {
      final controller = StreamController<SolicitudMobilidadData?>();
      when(() => repository.watchSolicitud('s-1')).thenAnswer((_) => controller.stream);

      await tester.pumpWidget(
        MaterialApp(
          home: CoordinatorSolicitudDetailPage(
            solicitudId: 's-1',
            repository: repository,
            coordinator: coordinator,
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      await controller.close();
    });

    testWidgets("muestra el mensaje 'no disponible' si la solicitud es null", (tester) async {
      when(() => repository.watchSolicitud('s-1'))
          .thenAnswer((_) => Stream<SolicitudMobilidadData?>.value(null));

      await tester.pumpWidget(
        MaterialApp(
          home: CoordinatorSolicitudDetailPage(
            solicitudId: 's-1',
            repository: repository,
            coordinator: coordinator,
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('La solicitud no esta disponible en la base local.'), findsOneWidget);
    });


    testWidgets('en el dialog de rechazo, confirmar sin texto muestra el error de validación', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ReviewDialog(approve: false),
          ),
        ),
      );

      await tester.tap(find.text('Rechazar'));
      await tester.pump();

      expect(find.text('Debes registrar un motivo.'), findsOneWidget);
    });

    testWidgets('en el dialog de aprobación, confirmar sin texto cierra el dialog', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ReviewDialog(approve: true),
          ),
        ),
      );

      await tester.tap(find.text('Aprobar'));
      await tester.pumpAndSettle();

      expect(find.byType(AlertDialog), findsNothing);
    });
 
  });
}

SolicitudMobilidadData _solicitud({
  required String id,
  required String estado,
}) {
  final now = DateTime(2026, 1, 1);
  return SolicitudMobilidadData(
    id: id,
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
    bloqueada: true,
    fechaCreacion: now,
    fechaActualizacion: now,
    pendingSync: false,
  );
}

UsuarioData _usuario() {
  final now = DateTime(2026, 1, 1);
  return UsuarioData(
    id: 'coord-1',
    nombre: 'Carla',
    apellido: 'Rojas',
    email: 'carla.rojas@udem.edu.co',
    rol: 'coordinador',
    estado: 'activo',
    createdAt: now,
    updatedAt: now,
    pendingSync: false,
  );
}

Future<void> _setCurrentUser(AppDatabase db) async {
  final now = DateTime(2026, 1, 1);
  await db.upsertUsuarioLocal(
    id: 'coord-1',
    nombre: 'Carla',
    apellido: 'Rojas',
    email: 'carla.rojas@udem.edu.co',
    rol: 'coordinador',
    estado: 'activo',
    createdAt: now,
    updatedAt: now,
    pendingSync: false,
  );
  final currentUser = await db.getUsuarioById('coord-1');
  db.setCurrentUser(currentUser);
}
