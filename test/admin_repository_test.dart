import 'package:drift/native.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:solicitudes_movilidad_academica/data/app_database.dart';
import 'package:solicitudes_movilidad_academica/features/admin/services/admin_firestore_service.dart';
import 'package:solicitudes_movilidad_academica/features/admin/services/admin_repository.dart';

class FakeAdminFirestoreService implements AdminFirestoreServiceBase {
  FakeAdminFirestoreService({this.remoteUsers = const []});

  final List<UsuarioData> remoteUsers;
  final List<UsuarioData> usuariosUpserted = [];
  final List<HistorialEstadoData> historialUpserted = [];

  @override
  Future<void> upsertUsuario(UsuarioData usuario, {String? createdBy}) async {
    usuariosUpserted.add(usuario);
  }

  @override
  Future<void> upsertHistorialUsuario(HistorialEstadoData historial) async {
    historialUpserted.add(historial);
  }

  @override
  Future<List<UsuarioData>> traerUsuariosDeAdmin(String adminId) async {
    return remoteUsers;
  }
}

void main() {
  late AppDatabase db;
  late FakeAdminFirestoreService remote;
  late AdminRepository repository;

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    remote = FakeAdminFirestoreService();
    repository = AdminRepository(
      database: db,
      remote: remote,
      auth: MockFirebaseAuth(),
    );
  });

  tearDown(() async {
    await db.close();
  });

  test('edita usuario y normaliza email sin cambiar firebase auth', () async {
    final user = await _createUser(
      db,
      id: 'user-1',
      nombre: 'Ana',
      apellido: 'Gomez',
      email: 'ana.gomez@udem.edu.co',
      rol: 'estudiante',
      estado: 'activo',
      pendingSync: false,
    );

    await repository.editarUsuario(
      id: user.id,
      nombre: 'Ana Maria',
      apellido: 'Gomez',
      email: 'ANA.GOMEZ@UDEM.EDU.CO',
      rol: 'coordinador',
    );

    final updated = await db.getUsuarioById(user.id);
    final historial = await db.getHistorialDeUsuario(user.id);

    expect(updated?.nombre, 'Ana Maria');
    expect(updated?.rol, 'coordinador');
    expect(updated?.email, 'ana.gomez@udem.edu.co');
    expect(updated?.pendingSync, isFalse);
    expect(remote.usuariosUpserted, hasLength(1));
    expect(historial, isEmpty);
  });

  test('cambia estado de usuario, registra historial y sincroniza', () async {
    final user = await _createUser(
      db,
      id: 'user-2',
      nombre: 'Carlos',
      apellido: 'Perez',
      email: 'carlos.perez@udem.edu.co',
      rol: 'estudiante',
      estado: 'activo',
      pendingSync: false,
    );

    await repository.cambiarEstadoUsuario(
      id: user.id,
      nuevoEstado: 'inactivo',
      comentario: 'Cuenta suspendida',
      registradoPor: 'admin-1',
    );

    final updated = await db.getUsuarioById(user.id);
    final historial = await db.getHistorialDeUsuario(user.id);

    expect(updated?.estado, 'inactivo');
    expect(updated?.pendingSync, isFalse);
    expect(remote.usuariosUpserted, hasLength(1));
    expect(historial, hasLength(1));
    expect(historial.first.estadoAnterior, 'activo');
    expect(historial.first.estadoNuevo, 'inactivo');
  });

  test('asigna rol, registra historial y sincroniza el usuario', () async {
    final user = await _createUser(
      db,
      id: 'user-3',
      nombre: 'Laura',
      apellido: 'Suarez',
      email: 'laura.suarez@udem.edu.co',
      rol: 'estudiante',
      estado: 'activo',
      pendingSync: false,
    );

    await repository.asignarRol(
      id: user.id,
      nuevoRol: 'coordinador',
      registradoPor: 'admin-1',
    );

    final updated = await db.getUsuarioById(user.id);
    final historial = await db.getHistorialDeUsuario(user.id);

    expect(updated?.rol, 'coordinador');
    expect(updated?.pendingSync, isFalse);
    expect(remote.usuariosUpserted, hasLength(1));
    expect(historial, hasLength(1));
    expect(historial.first.estadoAnterior, 'rol_estudiante');
    expect(historial.first.estadoNuevo, 'rol_coordinador');
  });

  test('sincroniza los usuarios remotos desde Firestore manteniendo al admin', () async {
    await _createUser(
      db,
      id: 'admin-1',
      nombre: 'Admin',
      apellido: 'Uno',
      email: 'admin@udem.edu.co',
      rol: 'administrador',
      estado: 'activo',
      pendingSync: false,
    );
    await _createUser(
      db,
      id: 'user-4',
      nombre: 'Pablo',
      apellido: 'Diaz',
      email: 'pablo.diaz@udem.edu.co',
      rol: 'estudiante',
      estado: 'activo',
      pendingSync: false,
    );
    remote = FakeAdminFirestoreService(remoteUsers: [
      UsuarioData(
        id: 'user-remote',
        nombre: 'Sofia',
        apellido: 'Lopez',
        email: 'sofia.lopez@udem.edu.co',
        rol: 'estudiante',
        estado: 'activo',
        createdAt: DateTime(2026, 1, 1),
        updatedAt: DateTime(2026, 1, 1),
        pendingSync: false,
      ),
    ]);
    repository = AdminRepository(database: db, remote: remote, auth: MockFirebaseAuth());

    await repository.sincronizarDesdeFirestore('admin-1');

    final usuarios = await db.getAllUsuarios();
    expect(usuarios.map((u) => u.id), contains('admin-1'));
    expect(usuarios.map((u) => u.id), contains('user-remote'));
    expect(usuarios.map((u) => u.id), isNot(contains('user-4')));
  });

  test('sincroniza pendientes de usuario e historial', () async {
    final user = await _createUser(
      db,
      id: 'user-5',
      nombre: 'Diego',
      apellido: 'Martinez',
      email: 'diego.martinez@udem.edu.co',
      rol: 'estudiante',
      estado: 'activo',
      pendingSync: true,
    );

    await db.registrarCambioEstadoUsuario(
      usuarioId: user.id,
      estadoAnterior: 'activo',
      estadoNuevo: 'inactivo',
      comentario: 'Prueba pendiente',
      registradoPor: 'admin-1',
    );

    await repository.syncPending();

    final pendientes = await db.getUsuariosPendientesSync();
    final historialPendiente = await db.getHistorialPendientesSync();

    expect(remote.usuariosUpserted, hasLength(1));
    expect(remote.historialUpserted, hasLength(1));
    expect(pendientes, isEmpty);
    expect(historialPendiente, isEmpty);
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
