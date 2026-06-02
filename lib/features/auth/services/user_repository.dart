import 'auth_service.dart';

class UserRepository {
  UserRepository({required AuthService authService}) : _authService = authService;

  final AuthService _authService;

  bool get isBusy => _authService.isBusy;
  String? get authError => _authService.authError;

  Future<bool> registerLocal({
    required String nombre,
    required String apellido,
    required String email,
    required String passwordHash,
    required String rol,
  }) {
    return _authService.register(
      nombre: nombre,
      apellido: apellido,
      email: email,
      password: passwordHash,
      rol: rol,
    );
  }

  Future<bool> loginLocal({
    required String email,
    required String password,
  }) {
    return _authService.login(email: email, password: password);
  }

  Future<void> syncPendingUsers() {
    return _authService.syncPendingUsers();
  }

  Future<void> logout() {
    return _authService.logout();
  }
}
