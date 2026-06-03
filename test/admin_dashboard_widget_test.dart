import 'package:drift/native.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:solicitudes_movilidad_academica/data/app_database.dart';
import 'package:solicitudes_movilidad_academica/features/admin/pages/admin_dashboard_page.dart';
import 'package:solicitudes_movilidad_academica/features/admin/services/admin_firestore_service.dart';
import 'package:solicitudes_movilidad_academica/features/admin/services/admin_repository.dart';
import 'package:solicitudes_movilidad_academica/features/auth/services/auth_service.dart';
import 'package:solicitudes_movilidad_academica/features/auth/services/user_firestore_service.dart';
import 'package:solicitudes_movilidad_academica/shared/models/usuario_model.dart';

class FakeUserFirestoreService implements UserFirestoreServiceBase {
  final Map<String, UsuarioModel> _storage = {};

  @override
  Future<void> upsertUser(UsuarioModel user) async {
    _storage[user.id] = user;
  }

  @override
  Future<UsuarioModel?> findByUid(String uid) async {
    return _storage[uid.trim()];
  }

  @override
  Future<UsuarioModel?> findByEmail(String email) async {
    final normalized = email.trim().toLowerCase();
    for (final user in _storage.values) {
      if (user.email.trim().toLowerCase() == normalized) {
        return user;
      }
    }
    return null;
  }
}

class FakeAdminFirestoreService implements AdminFirestoreServiceBase {
  FakeAdminFirestoreService({this.remoteUsers = const []});

  final List<UsuarioData> remoteUsers;
  bool syncPendingCalled = false;

  @override
  Future<void> upsertUsuario(UsuarioData usuario, {String? createdBy}) async {}

  @override
  Future<void> upsertHistorialUsuario(HistorialEstadoData historial) async {}

  @override
  Future<List<UsuarioData>> traerUsuariosDeAdmin(String adminId) async {
    return remoteUsers;
  }
}

void main() {
  testWidgets('AdminDashboardPage muestra usuarios y permite sincronizar', (tester) async {
    final db = AppDatabase(NativeDatabase.memory());
    addTearDown(() async {
      await db.close();
    });

    final authService = AuthService(
      database: db,
      firebaseAuth: MockFirebaseAuth(),
      remote: FakeUserFirestoreService(),
    );
    final fakeRemote = FakeAdminFirestoreService();
    final repository = AdminRepository(
      database: db,
      remote: fakeRemote,
      auth: MockFirebaseAuth(),
    );

    final admin = await _createUser(
      db,
      id: 'admin-1',
      nombre: 'Admin',
      apellido: 'Uno',
      email: 'admin@udem.edu.co',
      rol: 'administrador',
      estado: 'activo',
      pendingSync: false,
    );
    db.setCurrentUser(admin);

    await tester.pumpWidget(
      MaterialApp(
        home: AppStateScope(
          state: db,
          child: AuthServiceScope(
            service: authService,
            child: AdminDashboardPage(repository: repository),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Administrador'), findsOneWidget);
    expect(find.text('Gestión de usuarios'), findsOneWidget);
    expect(find.text('Total: 1 usuarios'), findsOneWidget);
    expect(find.text('Admin Uno'), findsOneWidget);

    await tester.tap(find.byTooltip('Sincronizar'));
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));

    expect(find.text('Datos sincronizados correctamente'), findsOneWidget);

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 1));
    await tester.idle();
    await tester.pumpAndSettle();
    await db.close();
  });
}

Future<UsuarioData> _createUser(
  AppDatabase db, {
  required String id,
  required String nombre,
  required String apellido,
  required String email,
  required String rol,
  required String estado,
  required bool pendingSync,
}) async {
  final now = DateTime(2026, 1, 1);
  await db.upsertUsuarioLocal(
    id: id,
    nombre: nombre,
    apellido: apellido,
    email: email,
    rol: rol,
    estado: estado,
    createdAt: now,
    updatedAt: now,
    pendingSync: pendingSync,
  );

  return (await db.getUsuarioById(id))!;
}
