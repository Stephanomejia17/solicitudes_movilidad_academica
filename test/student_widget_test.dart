import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';

import 'package:solicitudes_movilidad_academica/data/app_database.dart';
import 'package:solicitudes_movilidad_academica/features/auth/services/auth_service.dart';
import 'package:solicitudes_movilidad_academica/main.dart' show RootView;
import 'package:solicitudes_movilidad_academica/shared/services/app_theme.dart';

import 'helpers/test_database.dart';
import 'mocks/fake_user_firestore_service.dart';

class TestApp extends StatefulWidget {
  final AppDatabase database;
  final AuthService authService;

  const TestApp({super.key, required this.database, required this.authService});

  @override
  State<TestApp> createState() => _TestAppState();
}

class _TestAppState extends State<TestApp> {
  @override
  void initState() {
    super.initState();
    widget.authService.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return AuthServiceScope(
      service: widget.authService,
      child: AppStateScope(
        state: widget.database,
        child: MaterialApp(theme: buildAppTheme(), home: const RootView()),
      ),
    );
  }
}

void main() {
  testWidgets('muestra el flujo de autenticacion al iniciar', (tester) async {
    final database = createTestDatabase();
    final authService = AuthService(
      database: database,
      firebaseAuth: MockFirebaseAuth(),
      remote: FakeUserFirestoreService(),
    );

    await tester.pumpWidget(
      TestApp(database: database, authService: authService),
    );

    await tester.pumpAndSettle();

    debugDumpApp();

    expect(
      find.text('Ingresar'),
      findsWidgets,
    );
    expect(find.text('Registrar'), findsOneWidget);
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Contraseña'), findsOneWidget);

    await database.close();
  });
}
