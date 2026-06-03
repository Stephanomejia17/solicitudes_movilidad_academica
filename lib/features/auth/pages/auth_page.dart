import 'package:flutter/material.dart';

import '../services/auth_service.dart';
import '../services/user_repository.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool _showLogin = true;

  @override
  Widget build(BuildContext context) {
    final authService = AuthServiceScope.of(context);
    final repository = UserRepository(authService: authService);

    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 640),
          child: Card(
            margin: const EdgeInsets.all(24),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SegmentedButton<bool>(
                    segments: const [
                      ButtonSegment(value: true, label: Text('Ingresar')),
                      ButtonSegment(value: false, label: Text('Registrar')),
                    ],
                    selected: {_showLogin},
                    onSelectionChanged: (value) {
                      setState(() => _showLogin = value.first);
                    },
                  ),
                  const SizedBox(height: 20),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 250),
                    child: _showLogin
                        ? _LoginForm(
                            key: const ValueKey('login'),
                            repository: repository,
                          )
                        : _RegisterForm(
                            key: const ValueKey('register'),
                            repository: repository,
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _LoginForm extends StatefulWidget {
  const _LoginForm({super.key, required this.repository});

  final UserRepository repository;

  @override
  State<_LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<_LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final success = await widget.repository.loginLocal(
      email: _email.text,
      password: _password.text,
    );
    if (!mounted) return;

    if (!success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            widget.repository.authError ?? 'No fue posible ingresar.',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: _email,
            decoration: const InputDecoration(labelText: 'Email'),
            validator: (value) =>
                value == null || value.trim().isEmpty ? 'Requerido' : null,
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _password,
            obscureText: true,
            decoration: const InputDecoration(labelText: 'Contraseña'),
            validator: (value) =>
                value == null || value.trim().isEmpty ? 'Requerido' : null,
          ),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: widget.repository.isBusy ? null : _submit,
            child: Text(
              widget.repository.isBusy ? 'Ingresando...' : 'Ingresar',
            ),
          ),
        ],
      ),
    );
  }
}

class _RegisterForm extends StatefulWidget {
  const _RegisterForm({super.key, required this.repository});

  final UserRepository repository;

  @override
  State<_RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<_RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final _nombre = TextEditingController();
  final _apellido = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  String _rol = 'estudiante';

  @override
  void dispose() {
    _nombre.dispose();
    _apellido.dispose();
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final success = await widget.repository.registerLocal(
      nombre: _nombre.text,
      apellido: _apellido.text,
      email: _email.text,
      passwordHash: _password.text,
      rol: _rol,
    );
    if (!mounted) return;

    if (!success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            widget.repository.authError ?? 'No fue posible registrar.',
          ),
        ),
      );
      return;
    }

    // Registro exitoso. RootView detecta estado 'inactivo' y muestra
    // PendingApprovalPage automáticamente — no se necesita navegar aquí.
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: _nombre,
            decoration: const InputDecoration(labelText: 'Nombre'),
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _apellido,
            decoration: const InputDecoration(labelText: 'Apellido'),
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _email,
            decoration: const InputDecoration(labelText: 'Email'),
            validator: (value) =>
                value == null || value.trim().isEmpty ? 'Requerido' : null,
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _password,
            obscureText: true,
            decoration: const InputDecoration(labelText: 'Contraseña'),
            validator: (value) =>
                value == null || value.trim().isEmpty ? 'Requerido' : null,
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            value: _rol,
            items: const [
              DropdownMenuItem(value: 'estudiante', child: Text('Estudiante')),
              DropdownMenuItem(
                value: 'coordinador',
                child: Text('Coordinador'),
              ),
              DropdownMenuItem(
                value: 'administrador',
                child: Text('Administrador'),
              ),
            ],
            onChanged: (value) {
              if (value != null) setState(() => _rol = value);
            },
          ),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: widget.repository.isBusy ? null : _submit,
            child: Text(widget.repository.isBusy ? 'Creando...' : 'Registrar'),
          ),
        ],
      ),
    );
  }
}
