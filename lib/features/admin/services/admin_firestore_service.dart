import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../data/app_database.dart';
import '../../../shared/services/firestore_collections.dart';

abstract class AdminFirestoreServiceBase {
  Future<void> upsertUsuario(UsuarioData usuario, {String? createdBy});
  Future<void> upsertHistorialUsuario(HistorialEstadoData historial);
  Future<List<UsuarioData>> traerUsuariosDeAdmin(String adminId);
}

class AdminFirestoreService implements AdminFirestoreServiceBase {
  AdminFirestoreService({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _usuarios =>
      _firestore.collection(FirestoreCollections.users);

  CollectionReference<Map<String, dynamic>> get _historialUsuarios =>
      _firestore.collection(FirestoreCollections.userHistory);

  Future<void> upsertUsuario(UsuarioData usuario, {String? createdBy}) async {
    final payload = {
      'id': usuario.id,
      'nombre': usuario.nombre,
      'apellido': usuario.apellido,
      'email': usuario.email,
      'rol': _roleToRemote(usuario.rol),
      'estado': usuario.estado,
      'createdAt': Timestamp.fromDate(usuario.createdAt),
      'updatedAt': Timestamp.fromDate(usuario.updatedAt),
      'syncedAt': FieldValue.serverTimestamp(),
    };
    if (createdBy?.trim().isNotEmpty == true) {
      payload['createdBy'] = createdBy!.trim();
    }

    await _usuarios.doc(usuario.id).set(payload, SetOptions(merge: true));
  }

  Future<void> upsertHistorialUsuario(HistorialEstadoData historial) async {
    await _historialUsuarios
        .doc(historial.id)
        .set(_historialToMap(historial), SetOptions(merge: true));
  }

  Future<List<UsuarioData>> traerTodosLosUsuarios() async {
    try {
      final snapshot = await _usuarios.get();
      final usuarios = <UsuarioData>[];
      for (final doc in snapshot.docs) {
        final data = doc.data();
        final usuario = UsuarioData(
          id: data['id'] ?? '',
          nombre: data['nombre'] ?? '',
          apellido: data['apellido'] ?? '',
          email: data['email'] ?? '',
          rol: _roleFromRemote(data['rol'] ?? data['role'] ?? 'student'),
          estado: data['estado'] ?? 'activo',
          createdAt:
              (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
          updatedAt:
              (data['updatedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
          pendingSync: false,
        );
        usuarios.add(usuario);
      }
      return usuarios;
    } catch (_) {
      return [];
    }
  }

  Future<List<UsuarioData>> traerUsuariosDeAdmin(String adminId) async {
    try {
      final snapshot = await _usuarios
          .where('createdBy', isEqualTo: adminId)
          .get();
      final usuarios = <UsuarioData>[];
      for (final doc in snapshot.docs) {
        final data = doc.data();
        final usuario = UsuarioData(
          id: data['id'] ?? '',
          nombre: data['nombre'] ?? '',
          apellido: data['apellido'] ?? '',
          email: data['email'] ?? '',
          rol: _roleFromRemote(data['rol'] ?? data['role'] ?? 'student'),
          estado: data['estado'] ?? 'activo',
          createdAt:
              (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
          updatedAt:
              (data['updatedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
          pendingSync: false,
        );
        usuarios.add(usuario);
      }
      return usuarios;
    } catch (_) {
      return [];
    }
  }

  String _roleToRemote(String role) {
    return switch (role.trim().toLowerCase()) {
      'estudiante' => 'student',
      'coordinador' => 'coordinator',
      'administrador' => 'admin',
      _ => role,
    };
  }

  String _roleFromRemote(String role) {
    return switch (role.trim().toLowerCase()) {
      'student' => 'estudiante',
      'coordinator' => 'coordinador',
      'admin' => 'administrador',
      _ => role,
    };
  }

  Map<String, dynamic> _historialToMap(HistorialEstadoData historial) {
    return {
      'id': historial.id,
      'usuarioId': historial.usuarioId,
      'estadoAnterior': historial.estadoAnterior,
      'estadoNuevo': historial.estadoNuevo,
      'comentario': historial.comentario,
      'fechaCambio': Timestamp.fromDate(historial.fechaCambio),
      'registradoPor': historial.usuarioId,
      'syncedAt': FieldValue.serverTimestamp(),
    };
  }
}
