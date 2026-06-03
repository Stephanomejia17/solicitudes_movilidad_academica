import 'package:solicitudes_movilidad_academica/features/auth/services/user_firestore_service.dart';
import 'package:solicitudes_movilidad_academica/shared/models/usuario_model.dart';

/// stub sin Firestore real, retorna null en todo, simula usuario no logueado.
class FakeUserFirestoreService implements UserFirestoreServiceBase {
  @override
  Future<UsuarioModel?> findByUid(String uid) async => null;

  @override
  Future<UsuarioModel?> findByEmail(String email) async => null;

  @override
  Future<void> upsertUser(UsuarioModel user) async {}
}