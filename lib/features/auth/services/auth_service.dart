import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import '../../../data/app_database.dart';
import '../../../shared/models/usuario_model.dart';
import 'user_firestore_service.dart';

class AuthService extends ChangeNotifier {
  AuthService({
    required AppDatabase database,
    FirebaseAuth? firebaseAuth,
    UserFirestoreServiceBase? remote,
  }) : _database = database,
       _auth = firebaseAuth ?? FirebaseAuth.instance,
       _remote = remote ?? UserFirestoreService();

  final AppDatabase _database;
  final FirebaseAuth _auth;
  final UserFirestoreServiceBase _remote;

  StreamSubscription<User?>? _subscription;
  bool _initialized = false;

  bool _ready = false;
  bool _busy = false;
  String? _error;

  bool get isReady => _ready;
  bool get isBusy => _busy;
  String? get authError => _error;

  Future<void> initialize() async {
    if (_initialized) return;
    _initialized = true;

    _subscription = _auth.authStateChanges().listen(
      (user) async {
        await _handleAuthStateChange(user);
        if (!_ready) {
          _ready = true;
          notifyListeners();
        }
      },
      onError: (Object error, StackTrace stackTrace) {
        _error = _friendlyAuthError(error);
        _ready = true;
        notifyListeners();
      },
    );

    final currentUser = _auth.currentUser;
    if (currentUser != null) {
      await _handleAuthStateChange(currentUser);
      _ready = true;
      notifyListeners();
    } else {
      _ready = true;
      notifyListeners();
    }
  }

  bool _registering = false;

  Future<bool> register({
    required String nombre,
    required String apellido,
    required String email,
    required String password,
    required String rol,
  }) async {
    _setBusy(true);
    _error = null;
    _registering = true;
    try {
      final normalizedEmail = email.trim().toLowerCase();
      final credential = await _auth.createUserWithEmailAndPassword(
        email: normalizedEmail,
        password: password,
      );

      final firebaseUser = credential.user;
      if (firebaseUser == null) {
        _error = 'No fue posible crear la cuenta.';
        return false;
      }

      await firebaseUser.updateDisplayName(
        '${nombre.trim()} ${apellido.trim()}'.trim(),
      );

      final now = DateTime.now();
      final model = UsuarioModel(
        id: firebaseUser.uid,
        nombre: nombre.trim(),
        apellido: apellido.trim(),
        email: normalizedEmail,
        rol: rol.trim(),
        estado: 'inactivo',
        createdAt: now,
        updatedAt: now,
        pendingSync: false,
      );

      await _remote.upsertUser(model);
      await _cacheUser(model);
      return true;
    } on FirebaseAuthException catch (error) {
      _error = _friendlyAuthError(error);
      return false;
    } catch (_) {
      _error = 'No fue posible registrar el usuario.';
      return false;
    } finally {
      _registering = false;
      _setBusy(false);
    }
  }

  Future<bool> login({required String email, required String password}) async {
    _setBusy(true);
    _error = null;
    try {
      final normalizedEmail = email.trim().toLowerCase();
      await _auth.signInWithEmailAndPassword(
        email: normalizedEmail,
        password: password,
      );
      // Verificar estado del usuario en Firestore
      final firebaseUser = _auth.currentUser;
      if (firebaseUser != null) {
        final remoteUser =
            await _remote.findByUid(firebaseUser.uid) ??
            await _remote.findByEmail(normalizedEmail);
        if (remoteUser != null && remoteUser.estado != 'activo') {
          // Usuario inactivo: cerrar sesión y bloquear login
          await _auth.signOut();
          _error = 'La cuenta se encuentra inactiva.';
          return false;
        }
      }
      return true;
    } on FirebaseAuthException catch (error) {
      _error = _friendlyAuthError(error);
      print(' FirebaseAuthException: ${error.code} - ${error.message}');
      return false;
    } catch (stackTrace, e) {
      _error = 'Correo o contrasena incorrectos.';
      print('Error inesperado: $e');
      print(' StackTrace: $stackTrace');
      _error = 'Correo o contrasena incorrectos.';
      return false;
    } finally {
      _setBusy(false);
    }
  }

  Future<void> logout() async {
    _setBusy(true);
    _error = null;
    try {
      await _auth.signOut();
      _database.setCurrentUser(null);
    } finally {
      _setBusy(false);
    }
  }

  Future<void> syncPendingUsers() async {
    final user = _database.currentUser;
    if (user == null) return;

    // Solo sincronizar si realmente está pendiente
    if (!user.pendingSync) return;

    final model = UsuarioModel(
      id: user.id,
      nombre: user.nombre,
      apellido: user.apellido,
      email: user.email,
      rol: user.rol,
      estado: user.estado,
      createdAt: user.createdAt,
      updatedAt: user.updatedAt,
      pendingSync: user.pendingSync,
    );

    await _remote.upsertUser(model);

    await _database.marcarUsuarioSincronizado(user.id);
  }

  Future<void> _handleAuthStateChange(User? user) async {
    if (_registering) return;
    if (user == null) {
      _database.setCurrentUser(null);
      return;
    }
    await _syncProfile(user);
  }

  Future<void> _syncProfile(User firebaseUser) async {
    final email = firebaseUser.email?.trim().toLowerCase() ?? '';
    UsuarioModel? remoteUser = await _remote.findByUid(firebaseUser.uid);
    remoteUser ??= await _remote.findByEmail(email);

    // Bloquear y evitar cachear usuarios inactivos
    if (remoteUser != null && remoteUser.estado != 'activo') {
      try {
        await _auth.signOut();
      } catch (_) {}
      _database.setCurrentUser(null);
      _error = 'La cuenta se encuentra inactiva.';
      return;
    }

    final now = DateTime.now();
    final model =
        remoteUser ??
        UsuarioModel(
          id: firebaseUser.uid,
          nombre: firebaseUser.displayName?.trim().split(' ').first ?? '',
          apellido: '',
          email: email,
          rol: 'estudiante',
          estado: 'activo',
          createdAt: now,
          updatedAt: now,
          pendingSync: false,
        );

    await _cacheUser(model);
  }

  Future<void> _cacheUser(UsuarioModel user) async {
    print(' Guardando usuario local: ${user.id}');
    await _database.upsertUsuarioLocal(
      id: user.id,
      nombre: user.nombre,
      apellido: user.apellido,
      email: user.email,
      rol: user.rol,
      estado: user.estado,
      createdAt: user.createdAt,
      updatedAt: user.updatedAt,
      pendingSync: user.pendingSync,
    );

    final cached = await _database.getUsuarioByEmail(user.email);
    if (cached != null) {
      _database.setCurrentUser(cached);
    }
  }

  String _friendlyAuthError(Object error) {
    if (error is FirebaseAuthException) {
      return switch (error.code) {
        'email-already-in-use' => 'Ya existe una cuenta con este correo.',
        'weak-password' => 'La contrasena es demasiado debil.',
        'invalid-email' => 'El correo no tiene un formato valido.',
        'user-not-found' => 'No existe una cuenta con este correo.',
        'wrong-password' => 'Correo o contrasena incorrectos .',
        'invalid-credential' => 'Correo o contrasena incorrectos .',
        'too-many-requests' => 'Demasiados intentos. Intenta mas tarde.',
        _ => error.message ?? 'No fue posible completar la operacion.',
      };
    }

    return 'No fue posible completar la operacion.';
  }

  void _setBusy(bool value) {
    _busy = value;
    notifyListeners();
  }

  @override
  void dispose() {
    unawaited(_subscription?.cancel());
    super.dispose();
  }
}

class AuthServiceScope extends InheritedNotifier<AuthService> {
  const AuthServiceScope({
    super.key,
    required AuthService service,
    required super.child,
  }) : super(notifier: service);

  static AuthService of(BuildContext context) {
    final scope = context
        .dependOnInheritedWidgetOfExactType<AuthServiceScope>();
    assert(scope != null, 'AuthServiceScope no encontrado en el arbol.');
    return scope!.notifier!;
  }
}
