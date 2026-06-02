import 'package:drift/drift.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../data/app_database.dart';
import 'admin_firestore_service.dart';

class AdminRepository {
  AdminRepository({
    required this.database,
    AdminFirestoreService? remote,
    FirebaseAuth? auth,
  })  : _remote = remote ?? AdminFirestoreService(),
        _auth = auth ?? FirebaseAuth.instance;

  final AppDatabase database;
  final AdminFirestoreService _remote;
  final FirebaseAuth _auth;

  Stream<List<UsuarioData>> watchUsuarios() {
    return database.watchUsuarios();
  }

  Future<List<UsuarioData>> getAllUsuarios() {
    return database.getAllUsuarios();
  }

  Future<UsuarioData?> getUsuarioById(String id) {
    return database.getUsuarioById(id);
  }

  Future<String> crearUsuario({
    required String nombre,
    required String apellido,
    required String email,
    required String rol,
    required String contrasena,
    required String createdBy,
  }) async {
    final now = DateTime.now();
    final normalizedEmail = email.trim().toLowerCase();

    const apiKey = 'AIzaSyAQfPHlkC_LSNt70oELypNpp4gyfGe4L48';
    final uri = Uri.parse('https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$apiKey');
    final resp = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': normalizedEmail,
        'password': contrasena,
        'returnSecureToken': false,
      }),
    );

    if (resp.statusCode != 200) {
      final body = resp.body.isNotEmpty ? jsonDecode(resp.body) : null;
      final msg = body != null && body['error'] != null
          ? body['error']['message']
          : 'Error creando usuario';
      if (msg == 'EMAIL_EXISTS') {
        throw Exception('El email ya está registrado');
      }
      throw Exception(msg);
    }

    final data = jsonDecode(resp.body) as Map<String, dynamic>;
    final firebaseUid = data['localId'] as String?;
    if (firebaseUid == null || firebaseUid.isEmpty) {
      throw StateError('No fue posible obtener el uid del usuario creado');
    }

    final id = firebaseUid;

    await database.upsertUsuarioLocal(
      id: id,
      nombre: nombre,
      apellido: apellido,
      email: normalizedEmail,
      rol: rol,
      estado: 'activo',
      createdAt: now,
      updatedAt: now,
      pendingSync: true,
    );

    await database.registrarCambioEstadoUsuario(
      usuarioId: id,
      estadoAnterior: '',
      estadoNuevo: 'activo',
      comentario: 'Usuario creado',
      registradoPor: createdBy,
    );

    final usuario = await database.getUsuarioById(id);
    if (usuario != null) {
      await _remote.upsertUsuario(usuario, createdBy: createdBy);
      await database.marcarUsuarioSincronizado(id);
    }

    return id;
  }

  Future<void> editarUsuario({
    required String id,
    required String nombre,
    required String apellido,
    required String email,
    required String rol,
  }) async {
    final existing = await database.getUsuarioById(id);
    if (existing == null) {
      throw StateError('Usuario no encontrado');
    }

    final normalizedEmail = email.trim().toLowerCase();

    if (existing.email != normalizedEmail) {
      try {
        final user = _auth.currentUser;
        if (user?.uid == id) {
          await user?.verifyBeforeUpdateEmail(normalizedEmail);
        }
      } catch (_) {}
    }

    await database.updateUsuario(
      UsuariosCompanion(
        id: Value(id),
        nombre: Value(nombre),
        apellido: Value(apellido),
        email: Value(normalizedEmail),
        rol: Value(rol),
        pendingSync: const Value(true),
      ),
    );

    await syncUsuario(id);
  }

  Future<void> cambiarEstadoUsuario({
    required String id,
    required String nuevoEstado,
    String? comentario,
    String? registradoPor,
  }) async {
    final existing = await database.getUsuarioById(id);
    if (existing == null) {
      throw StateError('Usuario no encontrado');
    }

    final estadoAnterior = existing.estado;

    await database.setUsuarioEstado(id, nuevoEstado);

    await database.registrarCambioEstadoUsuario(
      usuarioId: id,
      estadoAnterior: estadoAnterior,
      estadoNuevo: nuevoEstado,
      comentario: comentario ?? 'Estado cambió a $nuevoEstado',
      registradoPor: registradoPor ?? '',
    );

    await syncUsuario(id);
  }

  Future<void> asignarRol({
    required String id,
    required String nuevoRol,
    String? registradoPor,
  }) async {
    final existing = await database.getUsuarioById(id);
    if (existing == null) {
      throw StateError('Usuario no encontrado');
    }

    await database.updateUsuario(
      UsuariosCompanion(
        id: Value(id),
        rol: Value(nuevoRol),
        pendingSync: const Value(true),
      ),
    );

    await database.registrarCambioEstadoUsuario(
      usuarioId: id,
      estadoAnterior: 'rol_${existing.rol}',
      estadoNuevo: 'rol_$nuevoRol',
      comentario: 'Rol asignado: $nuevoRol',
      registradoPor: registradoPor ?? '',
    );

    await syncUsuario(id);
  }

  Future<void> syncUsuario(String id) async {
    final usuario = await database.getUsuarioById(id);
    if (usuario == null) return;

    try {
      await _remote.upsertUsuario(usuario);
      await database.marcarUsuarioSincronizado(id);
    } catch (_) {}
  }

  Future<void> syncPending() async {
    final pendientes = await database.getUsuariosPendientesSync();
    for (final usuario in pendientes) {
      await syncUsuario(usuario.id);
    }

    final historialPendiente =
        await database.getHistorialPendientesSync();
    for (final historial in historialPendiente) {
      try {
        await _remote.upsertHistorialUsuario(historial);
        await database.marcarHistorialSincronizado(historial.id);
      } catch (_) {}
    }
  }

  Future<void> sincronizarDesdeFirestore(String adminId) async {
    try {
      await database.limpiarUsuariosExcepto(adminId);

      final usuariosRemoto = await _remote.traerUsuariosDeAdmin(adminId);

      for (final usuario in usuariosRemoto) {
        await database.upsertUsuarioLocal(
          id: usuario.id,
          nombre: usuario.nombre,
          apellido: usuario.apellido,
          email: usuario.email,
          rol: usuario.rol,
          estado: usuario.estado,
          createdAt: usuario.createdAt,
          updatedAt: usuario.updatedAt,
          pendingSync: false,
        );
      }
    } catch (_) {}
  }

  Future<List<HistorialEstadoData>> getHistorialUsuario(String usuarioId) {
    return database.getHistorialDeUsuario(usuarioId);
  }

  Stream<List<HistorialEstadoData>> watchHistorialUsuario(String usuarioId) {
    return database.watchHistorialDeUsuario(usuarioId);
  }
}
