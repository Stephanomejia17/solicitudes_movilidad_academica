part of '../../../main.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final state = AppStateScope.of(context);
    final pages = const [AdminDashboardPage(), UsersPage(), SettingsPage()];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Panel administrador'),
        actions: [
          IconButton(
            tooltip: 'Cerrar sesion',
            onPressed: state.logout,
            icon: const Icon(Icons.logout_rounded),
          ),
        ],
      ),
      body: IndexedStack(index: _currentIndex, children: pages),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (value) => setState(() => _currentIndex = value),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.dashboard_outlined),
            selectedIcon: Icon(Icons.dashboard_rounded),
            label: 'Resumen',
          ),
          NavigationDestination(
            icon: Icon(Icons.people_outline_rounded),
            selectedIcon: Icon(Icons.people_rounded),
            label: 'Usuarios',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings_rounded),
            label: 'Ajustes',
          ),
        ],
      ),
    );
  }
}

class AdminDashboardPage extends StatelessWidget {
  const AdminDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = AppStateScope.of(context);
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Text(
          'Gestion general del sistema',
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            _InfoCard(
              title: 'Solicitudes',
              value: '${state.totalApplications}',
              icon: Icons.inventory_2_outlined,
            ),
            _InfoCard(
              title: 'Enviadas',
              value: '${state.countByStatus(RequestStatus.submitted)}',
              icon: Icons.pending_actions_outlined,
            ),
            _InfoCard(
              title: 'Aprobadas',
              value: '${state.countByStatus(RequestStatus.approved)}',
              icon: Icons.check_circle_outline_rounded,
            ),
            _InfoCard(
              title: 'Rechazadas',
              value: '${state.countByStatus(RequestStatus.rejected)}',
              icon: Icons.highlight_off_rounded,
            ),
          ],
        ),
      ],
    );
  }
}

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = AppStateScope.of(context);
    return FutureBuilder<List<AppUser>>(
      future: state.getAllUsers(),
      builder: (context, snapshot) {
        final users = snapshot.data ?? const <AppUser>[];
        return ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Usuarios',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                FilledButton.icon(
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => const CreateUserPage(),
                    ),
                  ),
                  icon: const Icon(Icons.person_add_alt_rounded),
                  label: const Text('Crear'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (snapshot.connectionState == ConnectionState.waiting)
              const _SkeletonList()
            else if (users.isEmpty)
              const EmptyState(
                title: 'No hay usuarios',
                subtitle:
                    'Crea cuentas para estudiantes, coordinadores y administradores.',
                icon: Icons.people_outline_rounded,
              )
            else
              ...users.map(
                (user) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Card(
                    child: ListTile(
                      leading: const Icon(Icons.account_circle_outlined),
                      title: Text(user.fullName),
                      subtitle: Text('${user.email} · ${user.role.label}'),
                      trailing: Switch(
                        value: user.isActive,
                        onChanged: (value) =>
                            state.setUserActive(user.email, value),
                      ),
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (_) => EditUserPage(user: user),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

class CreateUserPage extends StatefulWidget {
  const CreateUserPage({super.key});

  @override
  State<CreateUserPage> createState() => _CreateUserPageState();
}

class _CreateUserPageState extends State<CreateUserPage> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  UserRole _role = UserRole.student;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Crear usuario')),
      body: _UserForm(
        formKey: _formKey,
        firstNameController: _firstNameController,
        lastNameController: _lastNameController,
        emailController: _emailController,
        passwordController: _passwordController,
        role: _role,
        onRoleChanged: (value) => setState(() => _role = value),
        actionLabel: 'Crear usuario',
        onSubmit: _save,
      ),
    );
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    final state = AppStateScope.of(context);
    await state.register(
      firstName: _firstNameController.text,
      lastName: _lastNameController.text,
      email: _emailController.text,
      password: _passwordController.text,
      role: _role,
    );
    if (mounted) {
      Navigator.of(context).pop();
    }
  }
}

class EditUserPage extends StatefulWidget {
  const EditUserPage({super.key, required this.user});

  final AppUser user;

  @override
  State<EditUserPage> createState() => _EditUserPageState();
}

class _EditUserPageState extends State<EditUserPage> {
  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late UserRole _role;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(text: widget.user.firstName);
    _lastNameController = TextEditingController(text: widget.user.lastName);
    _emailController = TextEditingController(text: widget.user.email);
    _passwordController = TextEditingController(text: widget.user.password);
    _role = widget.user.role;
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Editar usuario')),
      body: _UserForm(
        formKey: GlobalKey<FormState>(),
        firstNameController: _firstNameController,
        lastNameController: _lastNameController,
        emailController: _emailController,
        passwordController: _passwordController,
        role: _role,
        onRoleChanged: (value) => setState(() => _role = value),
        actionLabel: 'Guardar cambios',
        onSubmit: _save,
        lockEmail: true,
      ),
    );
  }

  Future<void> _save() async {
    final state = AppStateScope.of(context);
    await state.updateUser(
      widget.user.copyWith(
        firstName: _firstNameController.text.trim(),
        lastName: _lastNameController.text.trim(),
        password: _passwordController.text,
        role: _role,
        updatedAt: DateTime.now(),
      ),
    );
    if (mounted) {
      Navigator.of(context).pop();
    }
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: const [
        EmptyState(
          title: 'Configuracion general',
          subtitle:
              'Modulo reservado para parametros institucionales, convenios activos y requisitos documentales.',
          icon: Icons.tune_rounded,
        ),
      ],
    );
  }
}

class _UserForm extends StatelessWidget {
  const _UserForm({
    required this.formKey,
    required this.firstNameController,
    required this.lastNameController,
    required this.emailController,
    required this.passwordController,
    required this.role,
    required this.onRoleChanged,
    required this.actionLabel,
    required this.onSubmit,
    this.lockEmail = false,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final UserRole role;
  final ValueChanged<UserRole> onRoleChanged;
  final String actionLabel;
  final VoidCallback onSubmit;
  final bool lockEmail;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextFormField(
            controller: firstNameController,
            decoration: const InputDecoration(labelText: 'Nombres'),
            validator: validateRequired,
          ),
          const SizedBox(height: 14),
          TextFormField(
            controller: lastNameController,
            decoration: const InputDecoration(labelText: 'Apellidos'),
            validator: validateRequired,
          ),
          const SizedBox(height: 14),
          TextFormField(
            controller: emailController,
            readOnly: lockEmail,
            decoration: const InputDecoration(labelText: 'Correo electronico'),
            validator: validateEmail,
          ),
          const SizedBox(height: 14),
          TextFormField(
            controller: passwordController,
            obscureText: true,
            decoration: const InputDecoration(labelText: 'Contrasena'),
            validator: validatePassword,
          ),
          const SizedBox(height: 14),
          DropdownButtonFormField<UserRole>(
            initialValue: role,
            decoration: const InputDecoration(labelText: 'Rol'),
            items: UserRole.values
                .map(
                  (item) => DropdownMenuItem<UserRole>(
                    value: item,
                    child: Text(item.label),
                  ),
                )
                .toList(),
            onChanged: (value) {
              if (value != null) {
                onRoleChanged(value);
              }
            },
          ),
          const SizedBox(height: 20),
          FilledButton.icon(
            onPressed: onSubmit,
            icon: const Icon(Icons.save_outlined),
            label: Text(actionLabel),
          ),
        ],
      ),
    );
  }
}
