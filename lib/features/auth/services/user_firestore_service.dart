import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../data/app_database.dart';

class UserFirestoreService {
  UserFirestoreService({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _usuarios =>
      _firestore.collection('usuarios');
  CollectionReference<Map<String, dynamic>> get _users =>
      _firestore.collection('users');

  Future<void> upsertUser(UsuarioData user) async {
    final normalizedEmail = user.email.trim().toLowerCase();
    await _users
        .doc(normalizedEmail)
        .set(_userToMap(user), SetOptions(merge: true));
    await _usuarios
        .doc(user.id)
        .set(_usuarioToMap(user), SetOptions(merge: true));
  }

  Future<UsuarioRemoteData?> findByEmail(String email) async {
    final normalizedEmail = email.trim().toLowerCase();

    final userById = await _users.doc(normalizedEmail).get();
    if (userById.exists && userById.data() != null) {
      return UsuarioRemoteData.fromFirestore(userById.id, userById.data()!);
    }

    final userByEmail = await _findInCollection(_users, normalizedEmail);
    if (userByEmail != null) return userByEmail;

    final usuarioByEmail = await _findInCollection(_usuarios, normalizedEmail);
    if (usuarioByEmail != null) return usuarioByEmail;

    return null;
  }

  Future<UsuarioRemoteData?> _findInCollection(
    CollectionReference<Map<String, dynamic>> collection,
    String normalizedEmail,
  ) async {
    final snapshot = await collection
        .where('email', isEqualTo: normalizedEmail)
        .limit(1)
        .get();
    if (snapshot.docs.isEmpty) return null;

    final doc = snapshot.docs.first;
    return UsuarioRemoteData.fromFirestore(doc.id, doc.data());
  }

  Map<String, dynamic> _usuarioToMap(UsuarioData user) {
    return {
      'id': user.id,
      'nombre': user.nombre,
      'apellido': user.apellido,
      'email': user.email.trim().toLowerCase(),
      'passwordHash': user.passwordHash,
      'rol': user.rol,
      'estado': user.estado,
      'createdAt': Timestamp.fromDate(user.createdAt),
      'updatedAt': Timestamp.fromDate(user.updatedAt),
      'syncedAt': FieldValue.serverTimestamp(),
    };
  }

  Map<String, dynamic> _userToMap(UsuarioData user) {
    return {
      'id': user.id,
      'firstName': user.nombre,
      'lastName': user.apellido,
      'email': user.email.trim().toLowerCase(),
      'password': user.passwordHash,
      'passwordHash': user.passwordHash,
      'role': _roleToRemote(user.rol),
      'rol': user.rol,
      'isActive': user.estado == 'activo',
      'estado': user.estado,
      'createdAt': Timestamp.fromDate(user.createdAt),
      'updatedAt': Timestamp.fromDate(user.updatedAt),
      'syncedAt': FieldValue.serverTimestamp(),
    };
  }

  String _roleToRemote(String role) {
    return switch (role.trim().toLowerCase()) {
      'estudiante' => 'student',
      'coordinador' => 'coordinator',
      'administrador' => 'admin',
      _ => role,
    };
  }
}

class UsuarioRemoteData {
  const UsuarioRemoteData({
    required this.id,
    required this.nombre,
    required this.apellido,
    required this.email,
    required this.passwordHash,
    required this.rol,
    required this.estado,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String nombre;
  final String apellido;
  final String email;
  final String passwordHash;
  final String rol;
  final String estado;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory UsuarioRemoteData.fromFirestore(
    String documentId,
    Map<String, dynamic> data,
  ) {
    final now = DateTime.now();
    return UsuarioRemoteData(
      id: (data['id'] as String?)?.trim().isNotEmpty == true
          ? data['id'] as String
          : documentId,
      nombre: data['nombre'] as String? ?? data['firstName'] as String? ?? '',
      apellido:
          data['apellido'] as String? ?? data['lastName'] as String? ?? '',
      email: (data['email'] as String? ?? '').trim().toLowerCase(),
      passwordHash:
          data['passwordHash'] as String? ?? data['password'] as String? ?? '',
      rol: _normalizeRole(data['rol'] as String? ?? data['role'] as String?),
      estado: _normalizeStatus(
        estado: data['estado'] as String?,
        status: data['status'] as String?,
        isActive: data['isActive'],
      ),
      createdAt: _readDate(data['createdAt']) ?? now,
      updatedAt: _readDate(data['updatedAt']) ?? now,
    );
  }

  static String _normalizeRole(String? value) {
    return switch ((value ?? 'estudiante').trim().toLowerCase()) {
      'student' => 'estudiante',
      'coordinator' => 'coordinador',
      'admin' => 'administrador',
      'administrator' => 'administrador',
      final role => role,
    };
  }

  static String _normalizeStatus({
    required String? estado,
    required String? status,
    required Object? isActive,
  }) {
    if (isActive is bool) return isActive ? 'activo' : 'inactivo';
    return switch ((estado ?? status ?? 'activo').trim().toLowerCase()) {
      'active' => 'activo',
      'inactive' => 'inactivo',
      final value => value,
    };
  }

  static DateTime? _readDate(Object? value) {
    if (value is Timestamp) return value.toDate();
    if (value is DateTime) return value;
    if (value is String) return DateTime.tryParse(value);
    return null;
  }
}
