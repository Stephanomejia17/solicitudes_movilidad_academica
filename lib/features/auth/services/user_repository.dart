import 'package:solicitudes_movilidad_academica/data/app_database.dart';

import 'user_firestore_service.dart';

class UserRepository {
  UserRepository({required this.localDb, UserFirestoreService? remote})
    : _remote = remote ?? UserFirestoreService();

  final AppDatabase localDb;
  final UserFirestoreService _remote;

  Future<bool> registerLocal({
    required String nombre,
    required String apellido,
    required String email,
    required String passwordHash,
    required String rol,
  }) async {
    final normalizedEmail = email.trim().toLowerCase();
    localDb.authError = null;

    final remoteExisting = await _tryFindRemoteByEmail(normalizedEmail);
    if (remoteExisting != null) {
      await _cacheRemoteUser(remoteExisting, pendingSync: false);
      localDb.setAuthError('Ya existe una cuenta registrada con este correo.');
      return false;
    }

    final created = await localDb.register(
      nombre: nombre,
      apellido: apellido,
      email: normalizedEmail,
      passwordHash: passwordHash,
      rol: rol,
    );
    if (!created) return false;

    final user = await localDb.getUsuarioByEmail(normalizedEmail);
    if (user == null) {
      localDb.setAuthError('No fue posible preparar el usuario local.');
      return false;
    }

    final synced = await _tryUploadUser(user);
    if (!synced) {
      localDb.setAuthError(
        'Usuario creado localmente, pero no se pudo sincronizar con Firestore.',
      );
    }
    return true;
  }

  Future<bool> loginLocal({
    required String email,
    required String password,
  }) async {
    final normalizedEmail = email.trim().toLowerCase();
    localDb.authError = null;

    final localSuccess = await localDb.login(
      email: normalizedEmail,
      password: password,
    );
    if (localSuccess) return true;

    final remoteUser = await _tryFindRemoteByEmail(normalizedEmail);
    if (remoteUser == null ||
        remoteUser.passwordHash != password ||
        remoteUser.estado != 'activo') {
      localDb.setAuthError('Correo o contrasena incorrectos.');
      return false;
    }

    await _cacheRemoteUser(remoteUser, pendingSync: false);
    final cachedUser = await localDb.getUsuarioByEmail(normalizedEmail);
    localDb.setCurrentUser(cachedUser);
    return cachedUser != null;
  }

  Future<UsuarioData?> findByEmail(String email) {
    return localDb.getUsuarioByEmail(email);
  }

  Future<void> syncPendingUsers() async {
    final pendingUsers = await localDb.getUsuariosPendientesSync();
    for (final user in pendingUsers) {
      await _tryUploadUser(user);
    }
  }

  Future<UsuarioRemoteData?> _tryFindRemoteByEmail(String email) async {
    try {
      return await _remote.findByEmail(email);
    } catch (_) {
      return null;
    }
  }

  Future<bool> _tryUploadUser(UsuarioData user) async {
    try {
      await _remote.upsertUser(user);
      await localDb.marcarUsuarioSincronizado(user.id);
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<void> _cacheRemoteUser(
    UsuarioRemoteData user, {
    required bool pendingSync,
  }) {
    return localDb.upsertUsuarioLocal(
      id: user.id,
      nombre: user.nombre,
      apellido: user.apellido,
      email: user.email,
      passwordHash: user.passwordHash,
      rol: user.rol,
      estado: user.estado,
      createdAt: user.createdAt,
      updatedAt: user.updatedAt,
      pendingSync: pendingSync,
    );
  }
}
