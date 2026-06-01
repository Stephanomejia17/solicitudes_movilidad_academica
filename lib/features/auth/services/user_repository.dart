import 'package:solicitudes_movilidad_academica/data/app_database.dart';

class UserRepository {
  UserRepository({required this.localDb});

  final AppDatabase localDb;

  Future<bool> registerLocal({
    required String nombre,
    required String apellido,
    required String email,
    required String passwordHash,
    required String rol,
  }) {
    return localDb.register(
      nombre: nombre,
      apellido: apellido,
      email: email,
      passwordHash: passwordHash,
      rol: rol,
    );
  }

  Future<bool> loginLocal({
    required String email,
    required String password,
  }) {
    return localDb.login(email: email, password: password);
  }

  Future<UsuarioData?> findByEmail(String email) {
    return localDb.getUsuarioByEmail(email);
  }
}

