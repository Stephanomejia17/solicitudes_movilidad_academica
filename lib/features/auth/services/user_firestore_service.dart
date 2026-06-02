import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../shared/models/usuario_model.dart';

class UserFirestoreService {
  UserFirestoreService({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _usuarios =>
      _firestore.collection('usuarios');

  Future<void> upsertUser(UsuarioModel user) async {
    final payload = {
      ...user.toFirestore(),           
      'syncedAt': FieldValue.serverTimestamp(),
      'isActive': user.isActive,
      'role': _roleToRemote(user.rol),
    };
  
    await _usuarios.doc(user.id).set(payload, SetOptions(merge: true));
  }

  Future<UsuarioModel?> findByUid(String uid) async {
    final normalizedUid = uid.trim();
    if (normalizedUid.isEmpty) return null;

    final doc = await _usuarios.doc(normalizedUid).get();
    if (doc.exists && doc.data() != null) {
      return UsuarioModel.fromFirestore(doc.id, doc.data()!);
    }
    return null;
  }

  Future<UsuarioModel?> findByEmail(String email) async {
    final normalizedEmail = email.trim().toLowerCase();
    if (normalizedEmail.isEmpty) return null;

    return _findByField('email', normalizedEmail);
  }

  Future<UsuarioModel?> _findByField(String field, String value) async {
    final snapshot = await _usuarios
        .where(field, isEqualTo: value)
        .limit(1)
        .get();
    if (snapshot.docs.isEmpty) return null;

    final doc = snapshot.docs.first;
    return UsuarioModel.fromFirestore(doc.id, doc.data());
  }


  String _roleToRemote(String role) {
    return switch (role.trim().toLowerCase()) {
      'estudiante'    => 'student',
      'coordinador'   => 'coordinator',
      'administrador' => 'admin',
      _               => role,
    };
  }
}
