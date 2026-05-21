part of '../main.dart';

class AuthShell extends StatefulWidget {
  const AuthShell({super.key});

  @override
  State<AuthShell> createState() => _AuthShellState();
}

class _AuthShellState extends State<AuthShell> {
  bool showLogin = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              theme.colorScheme.primary.withValues(alpha: 0.14),
              Colors.white,
              const Color(0xFFE0F2FE),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1080),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final wide = constraints.maxWidth > 820;
                  return Padding(
                    padding: const EdgeInsets.all(20),
                    child: wide
                        ? Row(
                            children: [
                              const Expanded(child: _AuthHero()),
                              const SizedBox(width: 24),
                              Expanded(
                                child: _AuthPanel(
                                  showLogin: showLogin,
                                  onToggle: () {
                                    setState(() => showLogin = !showLogin);
                                  },
                                ),
                              ),
                            ],
                          )
                        : SingleChildScrollView(
                            child: Column(
                              children: [
                                const _AuthHero(compact: true),
                                const SizedBox(height: 20),
                                _AuthPanel(
                                  showLogin: showLogin,
                                  onToggle: () {
                                    setState(() => showLogin = !showLogin);
                                  },
                                ),
                              ],
                            ),
                          ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final state = AppStateScope.of(context);
    final success = await state.login(
      email: _emailController.text,
      password: _passwordController.text,
    );

    if (!mounted) {
      return;
    }

    if (!success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(state.authError ?? 'No fue posible ingresar.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = AppStateScope.of(context);
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Iniciar sesion',
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          Text(
            'Usa las cuentas demo `admin@xchange.edu.co` / `Admin123` o `user@xchange.edu.co` / `User12345`.',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.grey.shade700),
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelText: 'Correo electronico',
              prefixIcon: Icon(Icons.alternate_email_rounded),
            ),
            validator: validateEmail,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _passwordController,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'Contrasena',
              prefixIcon: Icon(Icons.lock_outline_rounded),
            ),
            validator: validatePassword,
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: state.isBusy ? null : _submit,
              icon: state.isBusy
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.login_rounded),
              label: Text(state.isBusy ? 'Ingresando...' : 'Ingresar'),
            ),
          ),
        ],
      ),
    );
  }
}

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key, required this.onRegistered});

  final VoidCallback onRegistered;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  UserRole _selectedRole = UserRole.user;

  @override
  void dispose() {
    _nameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final state = AppStateScope.of(context);
    final success = await state.register(
      firstName: _nameController.text,
      lastName: _lastNameController.text,
      email: _emailController.text,
      password: _passwordController.text,
      role: _selectedRole,
    );

    if (!mounted) {
      return;
    }

    if (success) {
      _formKey.currentState!.reset();
      _nameController.clear();
      _lastNameController.clear();
      _emailController.clear();
      _passwordController.clear();
      _confirmPasswordController.clear();
      setState(() => _selectedRole = UserRole.user);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Cuenta creada. Ahora puedes autenticarte.'),
        ),
      );
      widget.onRegistered();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(state.authError ?? 'No fue posible registrarte.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = AppStateScope.of(context);
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Crear cuenta',
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: 'Nombre',
              prefixIcon: Icon(Icons.person_outline_rounded),
            ),
            validator: validateRequired,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _lastNameController,
            decoration: const InputDecoration(
              labelText: 'Apellido',
              prefixIcon: Icon(Icons.badge_outlined),
            ),
            validator: validateRequired,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelText: 'Correo electronico',
              prefixIcon: Icon(Icons.alternate_email_rounded),
            ),
            validator: validateEmail,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _passwordController,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'Contrasena',
              prefixIcon: Icon(Icons.lock_outline_rounded),
            ),
            validator: validatePassword,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _confirmPasswordController,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'Confirmar contrasena',
              prefixIcon: Icon(Icons.verified_user_outlined),
            ),
            validator: (value) {
              final required = validateRequired(value);
              if (required != null) {
                return required;
              }
              if (value != _passwordController.text) {
                return 'Las contrasenas no coinciden.';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<UserRole>(
            key: ValueKey(_selectedRole),
            initialValue: _selectedRole,
            decoration: const InputDecoration(
              labelText: 'Rol',
              prefixIcon: Icon(Icons.manage_accounts_outlined),
            ),
            items: UserRole.values
                .map(
                  (role) =>
                      DropdownMenuItem(value: role, child: Text(role.label)),
                )
                .toList(),
            onChanged: (value) {
              if (value != null) {
                setState(() => _selectedRole = value);
              }
            },
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: state.isBusy ? null : _submit,
              icon: state.isBusy
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.person_add_alt_1_rounded),
              label: Text(state.isBusy ? 'Creando cuenta...' : 'Crear cuenta'),
            ),
          ),
        ],
      ),
    );
  }
}
