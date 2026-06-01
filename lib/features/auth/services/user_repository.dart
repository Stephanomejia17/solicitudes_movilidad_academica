import 'package:solicitudes_movilidad_academica/data/app_database.dart';
import 'package:solicitudes_movilidad_academica/model/record_model.dart';

class UserRepository {
  UserRepository({required this.localDb});

  final AppDatabase localDb;

  Future<AppUser> registerLocal({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required UserRole role,
  }) {
    return localDb.insertUser(
      AppUser(
        firstName: firstName.trim(),
        lastName: lastName.trim(),
        email: email.trim().toLowerCase(),
        password: password,
        role: role,
      ),
    );
  }

  Future<AppUser?> loginLocal({
    required String email,
    required String password,
  }) {
    return localDb.getUserByCredentials(email: email, password: password);
  }

  Future<AppUser?> findByEmail(String email) {
    return localDb.getUserByEmail(email);
  }
}
