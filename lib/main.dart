import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

enum UserRole { admin, user }

enum ApplicationStatus { pending, approved, rejected }

extension UserRoleX on UserRole {
  String get label => this == UserRole.admin ? 'Admin' : 'User';
}

extension ApplicationStatusX on ApplicationStatus {
  String get label => switch (this) {
    ApplicationStatus.pending => 'Pendiente',
    ApplicationStatus.approved => 'Aprobada',
    ApplicationStatus.rejected => 'Rechazada',
  };

  Color color(BuildContext context) => switch (this) {
    ApplicationStatus.pending => Colors.orange.shade700,
    ApplicationStatus.approved => Colors.green.shade700,
    ApplicationStatus.rejected => Theme.of(context).colorScheme.error,
  };
}

class AppUser {
  AppUser({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.role,
  });

  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final UserRole role;

  String get fullName => '$firstName $lastName';
}

class MobilityApplication {
  MobilityApplication({
    required this.id,
    required this.userEmail,
    required this.createdAt,
    required this.firstName,
    required this.lastName,
    required this.documentType,
    required this.documentNumber,
    required this.birthDate,
    required this.institutionalEmail,
    required this.personalEmail,
    required this.phone,
    required this.emergencyContact,
    required this.relationship,
    required this.currentUniversity,
    required this.faculty,
    required this.program,
    required this.currentSemester,
    required this.average,
    required this.languageLevel,
    required this.languageScore,
    required this.destinationUniversity,
    required this.country,
    required this.city,
    required this.destinationFaculty,
    required this.studyArea,
    required this.exchangeSemester,
    required this.travelDate,
    required this.returnDate,
    this.status = ApplicationStatus.pending,
    this.adminComment = '',
    this.rejectionReason = '',
  });

  final String id;
  final String userEmail;
  final DateTime createdAt;
  final String firstName;
  final String lastName;
  final String documentType;
  final String documentNumber;
  final DateTime birthDate;
  final String institutionalEmail;
  final String personalEmail;
  final String phone;
  final String emergencyContact;
  final String relationship;
  final String currentUniversity;
  final String faculty;
  final String program;
  final int currentSemester;
  final double average;
  final String languageLevel;
  final String languageScore;
  final String destinationUniversity;
  final String country;
  final String city;
  final String destinationFaculty;
  final String studyArea;
  final String exchangeSemester;
  final DateTime travelDate;
  final DateTime returnDate;
  final ApplicationStatus status;
  final String adminComment;
  final String rejectionReason;

  String get studentName => '$firstName $lastName';

  MobilityApplication copyWith({
    String? id,
    String? userEmail,
    DateTime? createdAt,
    String? firstName,
    String? lastName,
    String? documentType,
    String? documentNumber,
    DateTime? birthDate,
    String? institutionalEmail,
    String? personalEmail,
    String? phone,
    String? emergencyContact,
    String? relationship,
    String? currentUniversity,
    String? faculty,
    String? program,
    int? currentSemester,
    double? average,
    String? languageLevel,
    String? languageScore,
    String? destinationUniversity,
    String? country,
    String? city,
    String? destinationFaculty,
    String? studyArea,
    String? exchangeSemester,
    DateTime? travelDate,
    DateTime? returnDate,
    ApplicationStatus? status,
    String? adminComment,
    String? rejectionReason,
  }) {
    return MobilityApplication(
      id: id ?? this.id,
      userEmail: userEmail ?? this.userEmail,
      createdAt: createdAt ?? this.createdAt,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      documentType: documentType ?? this.documentType,
      documentNumber: documentNumber ?? this.documentNumber,
      birthDate: birthDate ?? this.birthDate,
      institutionalEmail: institutionalEmail ?? this.institutionalEmail,
      personalEmail: personalEmail ?? this.personalEmail,
      phone: phone ?? this.phone,
      emergencyContact: emergencyContact ?? this.emergencyContact,
      relationship: relationship ?? this.relationship,
      currentUniversity: currentUniversity ?? this.currentUniversity,
      faculty: faculty ?? this.faculty,
      program: program ?? this.program,
      currentSemester: currentSemester ?? this.currentSemester,
      average: average ?? this.average,
      languageLevel: languageLevel ?? this.languageLevel,
      languageScore: languageScore ?? this.languageScore,
      destinationUniversity:
          destinationUniversity ?? this.destinationUniversity,
      country: country ?? this.country,
      city: city ?? this.city,
      destinationFaculty: destinationFaculty ?? this.destinationFaculty,
      studyArea: studyArea ?? this.studyArea,
      exchangeSemester: exchangeSemester ?? this.exchangeSemester,
      travelDate: travelDate ?? this.travelDate,
      returnDate: returnDate ?? this.returnDate,
      status: status ?? this.status,
      adminComment: adminComment ?? this.adminComment,
      rejectionReason: rejectionReason ?? this.rejectionReason,
    );
  }
}

class AppState extends ChangeNotifier {
  final List<AppUser> _users = [
    AppUser(
      firstName: 'Ana',
      lastName: 'Admin',
      email: 'admin@xchange.edu.co',
      password: 'Admin123',
      role: UserRole.admin,
    ),
    AppUser(
      firstName: 'Sara',
      lastName: 'Estudiante',
      email: 'user@xchange.edu.co',
      password: 'User12345',
      role: UserRole.user,
    ),
  ];

  late final List<MobilityApplication> _applications = [
    MobilityApplication(
      id: 'SOL-001',
      userEmail: 'user@xchange.edu.co',
      createdAt: DateTime.now().subtract(const Duration(days: 5)),
      firstName: 'Sara',
      lastName: 'Estudiante',
      documentType: 'CC',
      documentNumber: '1032456789',
      birthDate: DateTime(2003, 3, 15),
      institutionalEmail: 'sara@udem.edu.co',
      personalEmail: 'sara.personal@email.com',
      phone: '3001234567',
      emergencyContact: 'Marta Estudiante',
      relationship: 'Madre',
      currentUniversity: 'Universidad de Medellin',
      faculty: 'Ingenieria',
      program: 'Ingenieria de Software',
      currentSemester: 7,
      average: 4.2,
      languageLevel: 'B2',
      languageScore: 'TOEFL 90',
      destinationUniversity: 'Universidad de Valencia',
      country: 'Espana',
      city: 'Valencia',
      destinationFaculty: 'Escuela Tecnica Superior',
      studyArea: 'Desarrollo de Software',
      exchangeSemester: '2026-2',
      travelDate: DateTime.now().add(const Duration(days: 120)),
      returnDate: DateTime.now().add(const Duration(days: 280)),
    ),
    MobilityApplication(
      id: 'SOL-002',
      userEmail: 'user@xchange.edu.co',
      createdAt: DateTime.now().subtract(const Duration(days: 20)),
      firstName: 'Sara',
      lastName: 'Estudiante',
      documentType: 'CC',
      documentNumber: '1032456789',
      birthDate: DateTime(2003, 3, 15),
      institutionalEmail: 'sara@udem.edu.co',
      personalEmail: 'sara.personal@email.com',
      phone: '3001234567',
      emergencyContact: 'Marta Estudiante',
      relationship: 'Madre',
      currentUniversity: 'Universidad de Medellin',
      faculty: 'Ingenieria',
      program: 'Ingenieria de Software',
      currentSemester: 7,
      average: 4.2,
      languageLevel: 'B2',
      languageScore: 'IELTS 7.0',
      destinationUniversity: 'Universidad de Buenos Aires',
      country: 'Argentina',
      city: 'Buenos Aires',
      destinationFaculty: 'Facultad de Ingenieria',
      studyArea: 'Analitica de Datos',
      exchangeSemester: '2026-1',
      travelDate: DateTime.now().subtract(const Duration(days: 40)),
      returnDate: DateTime.now().add(const Duration(days: 45)),
      status: ApplicationStatus.approved,
      adminComment: 'Documentacion completa y promedio destacado.',
    ),
    MobilityApplication(
      id: 'SOL-003',
      userEmail: 'user@xchange.edu.co',
      createdAt: DateTime.now().subtract(const Duration(days: 12)),
      firstName: 'Sara',
      lastName: 'Estudiante',
      documentType: 'CC',
      documentNumber: '1032456789',
      birthDate: DateTime(2003, 3, 15),
      institutionalEmail: 'sara@udem.edu.co',
      personalEmail: 'sara.personal@email.com',
      phone: '3001234567',
      emergencyContact: 'Marta Estudiante',
      relationship: 'Madre',
      currentUniversity: 'Universidad de Medellin',
      faculty: 'Ingenieria',
      program: 'Ingenieria de Software',
      currentSemester: 7,
      average: 3.9,
      languageLevel: 'B1',
      languageScore: 'DELF B1',
      destinationUniversity: 'Universite de Lille',
      country: 'Francia',
      city: 'Lille',
      destinationFaculty: 'Sciences et Technologies',
      studyArea: 'Sistemas Distribuidos',
      exchangeSemester: '2025-2',
      travelDate: DateTime.now().subtract(const Duration(days: 90)),
      returnDate: DateTime.now().subtract(const Duration(days: 10)),
      status: ApplicationStatus.rejected,
      adminComment: 'Se requiere reforzar el nivel de idioma.',
      rejectionReason: 'El soporte de idioma no cumple el minimo esperado.',
    ),
  ];

  AppUser? currentUser;
  bool isBusy = false;
  String? authError;
  int _sequence = 4;

  List<MobilityApplication> get applications => List.unmodifiable(
    _applications..sort((a, b) => b.createdAt.compareTo(a.createdAt)),
  );

  List<MobilityApplication> applicationsForUser(String email) =>
      applications.where((item) => item.userEmail == email).toList();

  int get totalApplications => _applications.length;
  int countByStatus(ApplicationStatus status) =>
      _applications.where((item) => item.status == status).length;

  Future<bool> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required UserRole role,
  }) async {
    isBusy = true;
    authError = null;
    notifyListeners();
    await Future<void>.delayed(const Duration(milliseconds: 900));

    final exists = _users.any(
      (user) => user.email.trim().toLowerCase() == email.trim().toLowerCase(),
    );
    if (exists) {
      authError = 'Ya existe una cuenta registrada con este correo.';
      isBusy = false;
      notifyListeners();
      return false;
    }

    _users.add(
      AppUser(
        firstName: firstName.trim(),
        lastName: lastName.trim(),
        email: email.trim().toLowerCase(),
        password: password,
        role: role,
      ),
    );
    isBusy = false;
    notifyListeners();
    return true;
  }

  Future<bool> login({required String email, required String password}) async {
    isBusy = true;
    authError = null;
    notifyListeners();
    await Future<void>.delayed(const Duration(milliseconds: 900));

    try {
      currentUser = _users.firstWhere(
        (user) =>
            user.email.trim().toLowerCase() == email.trim().toLowerCase() &&
            user.password == password,
      );
      isBusy = false;
      notifyListeners();
      return true;
    } catch (_) {
      authError = 'Correo o contrasena incorrectos.';
      isBusy = false;
      notifyListeners();
      return false;
    }
  }

  void logout() {
    currentUser = null;
    authError = null;
    notifyListeners();
  }

  Future<void> createApplication(MobilityApplication application) async {
    await _simulateAction();
    _applications.add(
      application.copyWith(id: 'SOL-${_sequence.toString().padLeft(3, '0')}'),
    );
    _sequence++;
    notifyListeners();
  }

  Future<void> updateApplication(MobilityApplication application) async {
    await _simulateAction();
    final index = _applications.indexWhere((item) => item.id == application.id);
    if (index >= 0) {
      _applications[index] = application;
      notifyListeners();
    }
  }

  Future<void> deleteApplication(String id) async {
    await _simulateAction();
    _applications.removeWhere((item) => item.id == id);
    notifyListeners();
  }

  Future<void> reviewApplication({
    required String id,
    required ApplicationStatus status,
    required String comment,
    String rejectionReason = '',
  }) async {
    await _simulateAction();
    final index = _applications.indexWhere((item) => item.id == id);
    if (index >= 0) {
      final current = _applications[index];
      _applications[index] = current.copyWith(
        status: status,
        adminComment: comment.trim(),
        rejectionReason: rejectionReason.trim(),
      );
      notifyListeners();
    }
  }

  Future<void> _simulateAction() async {
    isBusy = true;
    notifyListeners();
    await Future<void>.delayed(const Duration(milliseconds: 700));
    isBusy = false;
    notifyListeners();
  }
}

class AppStateScope extends InheritedNotifier<AppState> {
  const AppStateScope({
    super.key,
    required AppState state,
    required super.child,
  }) : super(notifier: state);

  static AppState of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<AppStateScope>();
    assert(scope != null, 'AppStateScope no encontrado en el arbol.');
    return scope!.notifier!;
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppState _state = AppState();

  @override
  Widget build(BuildContext context) {
    return AppStateScope(
      state: _state,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'XChange UdeM',
        theme: _buildTheme(),
        home: const RootView(),
      ),
    );
  }
}

ThemeData _buildTheme() {
  const seed = Color(0xFF0E7490);
  final colorScheme = ColorScheme.fromSeed(
    seedColor: seed,
    brightness: Brightness.light,
    surface: const Color(0xFFF7FAFC),
  );

  return ThemeData(
    useMaterial3: true,
    colorScheme: colorScheme,
    scaffoldBackgroundColor: const Color(0xFFF3F7FB),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: BorderSide(color: Colors.grey.shade200),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: BorderSide(color: seed, width: 1.5),
      ),
    ),
    cardTheme: CardThemeData(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      margin: EdgeInsets.zero,
    ),
    snackBarTheme: SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
  );
}

class RootView extends StatelessWidget {
  const RootView({super.key});

  @override
  Widget build(BuildContext context) {
    final state = AppStateScope.of(context);
    final user = state.currentUser;

    if (user == null) {
      return const AuthShell();
    }

    return user.role == UserRole.admin
        ? const AdminHomePage()
        : const StudentHomePage();
  }
}

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

class _AuthHero extends StatelessWidget {
  const _AuthHero({this.compact = false});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.all(compact ? 24 : 36),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        gradient: LinearGradient(
          colors: [theme.colorScheme.primary, const Color(0xFF155E75)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(999),
            ),
            child: const Text(
              'Movilidad academica UdeM',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 28),
          Text(
            'Gestiona tus intercambios desde un solo lugar.',
            style: theme.textTheme.headlineMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Registro, autenticacion, seguimiento de solicitudes y revision administrativa con una experiencia mobile-first.',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: Colors.white.withValues(alpha: 0.88),
              height: 1.5,
            ),
          ),
          const SizedBox(height: 28),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: const [
              _HeroChip(label: 'Material 3'),
              _HeroChip(label: 'Flujo por roles'),
              _HeroChip(label: 'CRUD completo'),
              _HeroChip(label: 'Estados y revision'),
            ],
          ),
        ],
      ),
    );
  }
}

class _HeroChip extends StatelessWidget {
  const _HeroChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _AuthPanel extends StatelessWidget {
  const _AuthPanel({required this.showLogin, required this.onToggle});

  final bool showLogin;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SegmentedButton<bool>(
              segments: const [
                ButtonSegment<bool>(value: true, label: Text('Login')),
                ButtonSegment<bool>(value: false, label: Text('Registro')),
              ],
              selected: {showLogin},
              onSelectionChanged: (_) => onToggle(),
            ),
            const SizedBox(height: 24),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              child: showLogin
                  ? const LoginPage(key: ValueKey('login'))
                  : RegisterPage(
                      key: const ValueKey('register'),
                      onRegistered: onToggle,
                    ),
            ),
          ],
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

class StudentHomePage extends StatefulWidget {
  const StudentHomePage({super.key});

  @override
  State<StudentHomePage> createState() => _StudentHomePageState();
}

class _StudentHomePageState extends State<StudentHomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final state = AppStateScope.of(context);
    final user = state.currentUser!;
    final pages = [
      StudentDashboard(user: user, onCreateRequest: () => _openForm(context)),
      StudentRequestsPage(
        user: user,
        onCreateRequest: () => _openForm(context),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Portal estudiante'),
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
        onDestinationSelected: (index) => setState(() => _currentIndex = index),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.dashboard_outlined),
            selectedIcon: Icon(Icons.dashboard_rounded),
            label: 'Dashboard',
          ),
          NavigationDestination(
            icon: Icon(Icons.assignment_outlined),
            selectedIcon: Icon(Icons.assignment_rounded),
            label: 'Solicitudes',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openForm(context),
        icon: const Icon(Icons.add_rounded),
        label: const Text('Nueva solicitud'),
      ),
    );
  }

  Future<void> _openForm(
    BuildContext context, {
    MobilityApplication? application,
  }) async {
    final state = AppStateScope.of(context);
    final user = state.currentUser!;
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) =>
            ApplicationFormPage(currentUser: user, existing: application),
      ),
    );
  }
}

class StudentDashboard extends StatelessWidget {
  const StudentDashboard({
    super.key,
    required this.user,
    required this.onCreateRequest,
  });

  final AppUser user;
  final VoidCallback onCreateRequest;

  @override
  Widget build(BuildContext context) {
    final state = AppStateScope.of(context);
    final requests = state.applicationsForUser(user.email);
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        _WelcomeBanner(user: user, onCreateRequest: onCreateRequest),
        const SizedBox(height: 20),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            _InfoCard(
              title: 'Total solicitudes',
              value: '${requests.length}',
              icon: Icons.folder_copy_outlined,
            ),
            _InfoCard(
              title: 'Pendientes',
              value:
                  '${requests.where((e) => e.status == ApplicationStatus.pending).length}',
              icon: Icons.schedule_rounded,
            ),
            _InfoCard(
              title: 'Aprobadas',
              value:
                  '${requests.where((e) => e.status == ApplicationStatus.approved).length}',
              icon: Icons.check_circle_outline_rounded,
            ),
          ],
        ),
        const SizedBox(height: 20),
        Text(
          'Historial reciente',
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 12),
        if (state.isBusy)
          const _SkeletonList()
        else if (requests.isEmpty)
          const EmptyState(
            title: 'Aun no tienes solicitudes',
            subtitle:
                'Crea tu primera solicitud de intercambio para empezar el proceso.',
            icon: Icons.inbox_outlined,
          )
        else
          ...requests
              .take(3)
              .map(
                (item) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: RequestSummaryCard(application: item),
                ),
              ),
      ],
    );
  }
}

class StudentRequestsPage extends StatelessWidget {
  const StudentRequestsPage({
    super.key,
    required this.user,
    required this.onCreateRequest,
  });

  final AppUser user;
  final VoidCallback onCreateRequest;

  @override
  Widget build(BuildContext context) {
    final state = AppStateScope.of(context);
    final requests = state.applicationsForUser(user.email);

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        if (state.isBusy)
          const _SkeletonList()
        else if (requests.isEmpty)
          EmptyState(
            title: 'No hay solicitudes registradas',
            subtitle: 'Usa el boton inferior para crear una nueva solicitud.',
            icon: Icons.edit_document,
            actionLabel: 'Nueva solicitud',
            onAction: onCreateRequest,
          )
        else
          ...requests.map(
            (application) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: RequestSummaryCard(
                application: application,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => StudentApplicationDetailPage(
                        applicationId: application.id,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
      ],
    );
  }
}

class StudentApplicationDetailPage extends StatelessWidget {
  const StudentApplicationDetailPage({super.key, required this.applicationId});

  final String applicationId;

  @override
  Widget build(BuildContext context) {
    final state = AppStateScope.of(context);
    final application = state.applications.firstWhere(
      (item) => item.id == applicationId,
    );
    final user = state.currentUser!;

    return Scaffold(
      appBar: AppBar(title: Text('Solicitud ${application.id}')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _StatusHeader(application: application),
          const SizedBox(height: 16),
          _DetailSection(
            title: 'Informacion personal',
            rows: [
              _detailRow('Nombres', application.firstName),
              _detailRow('Apellidos', application.lastName),
              _detailRow(
                'Documento',
                '${application.documentType} ${application.documentNumber}',
              ),
              _detailRow('Nacimiento', formatDate(application.birthDate)),
              _detailRow(
                'Correo institucional',
                application.institutionalEmail,
              ),
              _detailRow('Correo personal', application.personalEmail),
              _detailRow('Celular', application.phone),
              _detailRow('Emergencia', application.emergencyContact),
              _detailRow('Parentesco', application.relationship),
            ],
          ),
          const SizedBox(height: 16),
          _DetailSection(
            title: 'Informacion academica',
            rows: [
              _detailRow('Universidad actual', application.currentUniversity),
              _detailRow('Facultad', application.faculty),
              _detailRow('Programa', application.program),
              _detailRow('Semestre', '${application.currentSemester}'),
              _detailRow('Promedio', application.average.toStringAsFixed(1)),
              _detailRow('Nivel idioma', application.languageLevel),
              _detailRow('Puntaje', application.languageScore),
            ],
          ),
          const SizedBox(height: 16),
          _DetailSection(
            title: 'Movilidad',
            rows: [
              _detailRow(
                'Universidad destino',
                application.destinationUniversity,
              ),
              _detailRow('Pais', application.country),
              _detailRow('Ciudad', application.city),
              _detailRow('Facultad destino', application.destinationFaculty),
              _detailRow('Area de estudio', application.studyArea),
              _detailRow('Semestre intercambio', application.exchangeSemester),
              _detailRow('Viaje estimado', formatDate(application.travelDate)),
              _detailRow(
                'Regreso estimado',
                formatDate(application.returnDate),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: application.status == ApplicationStatus.pending
                    ? () {
                        Navigator.of(context).push(
                          MaterialPageRoute<void>(
                            builder: (_) => ApplicationFormPage(
                              currentUser: user,
                              existing: application,
                            ),
                          ),
                        );
                      }
                    : null,
                icon: const Icon(Icons.edit_outlined),
                label: const Text('Editar'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: FilledButton.tonalIcon(
                onPressed: () async {
                  final confirmed = await showDialog<bool>(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text('Eliminar solicitud'),
                      content: const Text(
                        'Esta accion no se puede deshacer. ¿Deseas continuar?',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          child: const Text('Cancelar'),
                        ),
                        FilledButton(
                          onPressed: () => Navigator.of(context).pop(true),
                          child: const Text('Eliminar'),
                        ),
                      ],
                    ),
                  );

                  if (confirmed == true && context.mounted) {
                    await state.deleteApplication(application.id);
                    if (!context.mounted) {
                      return;
                    }
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Solicitud eliminada.')),
                    );
                    Navigator.of(context).pop();
                  }
                },
                icon: const Icon(Icons.delete_outline_rounded),
                label: const Text('Eliminar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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
    final pages = const [
      AdminDashboard(),
      AdminRequestsList(status: ApplicationStatus.pending),
      AdminRequestsList(status: ApplicationStatus.approved),
      AdminRequestsList(status: ApplicationStatus.rejected),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Panel administrativo'),
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
            icon: Icon(Icons.analytics_outlined),
            selectedIcon: Icon(Icons.analytics_rounded),
            label: 'Resumen',
          ),
          NavigationDestination(
            icon: Icon(Icons.hourglass_empty_rounded),
            selectedIcon: Icon(Icons.hourglass_top_rounded),
            label: 'Pendientes',
          ),
          NavigationDestination(
            icon: Icon(Icons.task_alt_outlined),
            selectedIcon: Icon(Icons.task_alt_rounded),
            label: 'Aprobadas',
          ),
          NavigationDestination(
            icon: Icon(Icons.cancel_outlined),
            selectedIcon: Icon(Icons.cancel_rounded),
            label: 'Rechazadas',
          ),
        ],
      ),
    );
  }
}

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final state = AppStateScope.of(context);
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Text(
          'Estadisticas de solicitudes',
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
              title: 'Total',
              value: '${state.totalApplications}',
              icon: Icons.inventory_2_outlined,
            ),
            _InfoCard(
              title: 'Pendientes',
              value: '${state.countByStatus(ApplicationStatus.pending)}',
              icon: Icons.pending_actions_outlined,
            ),
            _InfoCard(
              title: 'Aprobadas',
              value: '${state.countByStatus(ApplicationStatus.approved)}',
              icon: Icons.check_circle_outline_rounded,
            ),
            _InfoCard(
              title: 'Rechazadas',
              value: '${state.countByStatus(ApplicationStatus.rejected)}',
              icon: Icons.highlight_off_rounded,
            ),
          ],
        ),
        const SizedBox(height: 20),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Distribucion por estado',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 20),
                _StatusChart(
                  values: {
                    'Pendientes': state.countByStatus(
                      ApplicationStatus.pending,
                    ),
                    'Aprobadas': state.countByStatus(
                      ApplicationStatus.approved,
                    ),
                    'Rechazadas': state.countByStatus(
                      ApplicationStatus.rejected,
                    ),
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class AdminRequestsList extends StatelessWidget {
  const AdminRequestsList({super.key, required this.status});

  final ApplicationStatus status;

  @override
  Widget build(BuildContext context) {
    final state = AppStateScope.of(context);
    final requests = state.applications
        .where((item) => item.status == status)
        .toList();
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Text(
          'Solicitudes ${status.label.toLowerCase()}',
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 16),
        if (state.isBusy)
          const _SkeletonList()
        else if (requests.isEmpty)
          EmptyState(
            title: 'No hay solicitudes ${status.label.toLowerCase()}',
            subtitle: 'Cuando existan registros apareceran aqui.',
            icon: Icons.filter_alt_off_outlined,
          )
        else
          ...requests.map(
            (application) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: RequestSummaryCard(
                application: application,
                subtitle:
                    '${application.destinationUniversity} · ${formatDate(application.createdAt)}',
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => AdminApplicationDetailPage(
                        applicationId: application.id,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
      ],
    );
  }
}

class AdminApplicationDetailPage extends StatefulWidget {
  const AdminApplicationDetailPage({super.key, required this.applicationId});

  final String applicationId;

  @override
  State<AdminApplicationDetailPage> createState() =>
      _AdminApplicationDetailPageState();
}

class _AdminApplicationDetailPageState
    extends State<AdminApplicationDetailPage> {
  final _commentController = TextEditingController();
  final _reasonController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    _reasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = AppStateScope.of(context);
    final application = state.applications.firstWhere(
      (item) => item.id == widget.applicationId,
    );
    _commentController.text = application.adminComment;
    _reasonController.text = application.rejectionReason;

    return Scaffold(
      appBar: AppBar(title: Text('Revision ${application.id}')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _StatusHeader(application: application),
          const SizedBox(height: 16),
          _DetailSection(
            title: 'Resumen del estudiante',
            rows: [
              _detailRow('Nombre', application.studentName),
              _detailRow(
                'Correos',
                '${application.institutionalEmail} / ${application.personalEmail}',
              ),
              _detailRow(
                'Destino',
                '${application.destinationUniversity}, ${application.country}',
              ),
              _detailRow('Promedio', application.average.toStringAsFixed(1)),
              _detailRow(
                'Idioma',
                '${application.languageLevel} · ${application.languageScore}',
              ),
            ],
          ),
          const SizedBox(height: 16),
          _DetailSection(
            title: 'Detalle completo',
            rows: [
              _detailRow(
                'Documento',
                '${application.documentType} ${application.documentNumber}',
              ),
              _detailRow('Nacimiento', formatDate(application.birthDate)),
              _detailRow('Celular', application.phone),
              _detailRow('Contacto emergencia', application.emergencyContact),
              _detailRow('Parentesco', application.relationship),
              _detailRow('Universidad actual', application.currentUniversity),
              _detailRow('Facultad', application.faculty),
              _detailRow('Programa', application.program),
              _detailRow('Semestre actual', '${application.currentSemester}'),
              _detailRow('Area de estudio', application.studyArea),
              _detailRow('Semestre intercambio', application.exchangeSemester),
              _detailRow('Viaje', formatDate(application.travelDate)),
              _detailRow('Regreso', formatDate(application.returnDate)),
            ],
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  TextFormField(
                    controller: _commentController,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      labelText: 'Comentario administrativo',
                      alignLabelWithHint: true,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _reasonController,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      labelText: 'Motivo de rechazo',
                      alignLabelWithHint: true,
                      helperText:
                          'Obligatorio solo cuando la solicitud es rechazada.',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () => _review(
                  status: ApplicationStatus.rejected,
                  requireReason: true,
                ),
                icon: const Icon(Icons.close_rounded),
                label: const Text('Rechazar'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: FilledButton.icon(
                onPressed: () => _review(
                  status: ApplicationStatus.approved,
                  requireReason: false,
                ),
                icon: const Icon(Icons.check_rounded),
                label: const Text('Aprobar'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _review({
    required ApplicationStatus status,
    required bool requireReason,
  }) async {
    final state = AppStateScope.of(context);
    if (requireReason && _reasonController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Debes ingresar un motivo de rechazo.')),
      );
      return;
    }

    await state.reviewApplication(
      id: widget.applicationId,
      status: status,
      comment: _commentController.text,
      rejectionReason: requireReason ? _reasonController.text : '',
    );

    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Solicitud ${status.label.toLowerCase()} correctamente.'),
      ),
    );
    Navigator.of(context).pop();
  }
}

class ApplicationFormPage extends StatefulWidget {
  const ApplicationFormPage({
    super.key,
    required this.currentUser,
    this.existing,
  });

  final AppUser currentUser;
  final MobilityApplication? existing;

  @override
  State<ApplicationFormPage> createState() => _ApplicationFormPageState();
}

class _ApplicationFormPageState extends State<ApplicationFormPage> {
  final _formKey = GlobalKey<FormState>();
  int _currentStep = 0;

  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _documentTypeController;
  late final TextEditingController _documentNumberController;
  late final TextEditingController _birthDateController;
  late final TextEditingController _institutionalEmailController;
  late final TextEditingController _personalEmailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _emergencyContactController;
  late final TextEditingController _relationshipController;
  late final TextEditingController _currentUniversityController;
  late final TextEditingController _facultyController;
  late final TextEditingController _programController;
  late final TextEditingController _currentSemesterController;
  late final TextEditingController _averageController;
  late final TextEditingController _languageLevelController;
  late final TextEditingController _languageScoreController;
  late final TextEditingController _destinationUniversityController;
  late final TextEditingController _countryController;
  late final TextEditingController _cityController;
  late final TextEditingController _destinationFacultyController;
  late final TextEditingController _studyAreaController;
  late final TextEditingController _exchangeSemesterController;
  late final TextEditingController _travelDateController;
  late final TextEditingController _returnDateController;

  DateTime? _birthDate;
  DateTime? _travelDate;
  DateTime? _returnDate;

  @override
  void initState() {
    super.initState();
    final existing = widget.existing;
    _birthDate = existing?.birthDate;
    _travelDate = existing?.travelDate;
    _returnDate = existing?.returnDate;
    _firstNameController = TextEditingController(
      text: existing?.firstName ?? widget.currentUser.firstName,
    );
    _lastNameController = TextEditingController(
      text: existing?.lastName ?? widget.currentUser.lastName,
    );
    _documentTypeController = TextEditingController(
      text: existing?.documentType ?? 'CC',
    );
    _documentNumberController = TextEditingController(
      text: existing?.documentNumber ?? '',
    );
    _birthDateController = TextEditingController(
      text: existing != null ? formatDate(existing.birthDate) : '',
    );
    _institutionalEmailController = TextEditingController(
      text: existing?.institutionalEmail ?? widget.currentUser.email,
    );
    _personalEmailController = TextEditingController(
      text: existing?.personalEmail ?? '',
    );
    _phoneController = TextEditingController(text: existing?.phone ?? '');
    _emergencyContactController = TextEditingController(
      text: existing?.emergencyContact ?? '',
    );
    _relationshipController = TextEditingController(
      text: existing?.relationship ?? '',
    );
    _currentUniversityController = TextEditingController(
      text: existing?.currentUniversity ?? 'Universidad de Medellin',
    );
    _facultyController = TextEditingController(text: existing?.faculty ?? '');
    _programController = TextEditingController(text: existing?.program ?? '');
    _currentSemesterController = TextEditingController(
      text: existing?.currentSemester.toString() ?? '',
    );
    _averageController = TextEditingController(
      text: existing?.average.toString() ?? '',
    );
    _languageLevelController = TextEditingController(
      text: existing?.languageLevel ?? '',
    );
    _languageScoreController = TextEditingController(
      text: existing?.languageScore ?? '',
    );
    _destinationUniversityController = TextEditingController(
      text: existing?.destinationUniversity ?? '',
    );
    _countryController = TextEditingController(text: existing?.country ?? '');
    _cityController = TextEditingController(text: existing?.city ?? '');
    _destinationFacultyController = TextEditingController(
      text: existing?.destinationFaculty ?? '',
    );
    _studyAreaController = TextEditingController(
      text: existing?.studyArea ?? '',
    );
    _exchangeSemesterController = TextEditingController(
      text: existing?.exchangeSemester ?? '',
    );
    _travelDateController = TextEditingController(
      text: existing != null ? formatDate(existing.travelDate) : '',
    );
    _returnDateController = TextEditingController(
      text: existing != null ? formatDate(existing.returnDate) : '',
    );
  }

  @override
  void dispose() {
    for (final controller in [
      _firstNameController,
      _lastNameController,
      _documentTypeController,
      _documentNumberController,
      _birthDateController,
      _institutionalEmailController,
      _personalEmailController,
      _phoneController,
      _emergencyContactController,
      _relationshipController,
      _currentUniversityController,
      _facultyController,
      _programController,
      _currentSemesterController,
      _averageController,
      _languageLevelController,
      _languageScoreController,
      _destinationUniversityController,
      _countryController,
      _cityController,
      _destinationFacultyController,
      _studyAreaController,
      _exchangeSemesterController,
      _travelDateController,
      _returnDateController,
    ]) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.existing != null;
    final state = AppStateScope.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Editar solicitud' : 'Nueva solicitud'),
      ),
      body: Form(
        key: _formKey,
        child: Stepper(
          currentStep: _currentStep,
          onStepTapped: (step) => setState(() => _currentStep = step),
          onStepContinue: () {
            if (_currentStep < 2) {
              setState(() => _currentStep += 1);
            } else {
              _save();
            }
          },
          onStepCancel: () {
            if (_currentStep > 0) {
              setState(() => _currentStep -= 1);
            } else {
              Navigator.of(context).pop();
            }
          },
          controlsBuilder: (context, details) {
            return Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  FilledButton(
                    onPressed: state.isBusy ? null : details.onStepContinue,
                    child: Text(
                      _currentStep == 2
                          ? (state.isBusy
                                ? 'Guardando...'
                                : 'Guardar solicitud')
                          : 'Continuar',
                    ),
                  ),
                  OutlinedButton(
                    onPressed: state.isBusy ? null : details.onStepCancel,
                    child: Text(_currentStep == 0 ? 'Cancelar' : 'Atras'),
                  ),
                ],
              ),
            );
          },
          steps: [
            Step(
              isActive: _currentStep >= 0,
              title: const Text('Personal'),
              content: Column(
                children: [
                  _buildTextField(_firstNameController, 'Nombres'),
                  _buildTextField(_lastNameController, 'Apellidos'),
                  _buildTextField(_documentTypeController, 'Tipo de documento'),
                  _buildTextField(
                    _documentNumberController,
                    'Numero de documento',
                    keyboardType: TextInputType.number,
                  ),
                  _DatePickerField(
                    controller: _birthDateController,
                    label: 'Fecha de nacimiento',
                    onSelected: (value) {
                      _birthDate = value;
                    },
                    initialDate: _birthDate,
                    firstDate: DateTime(1980),
                    lastDate: DateTime.now().subtract(
                      const Duration(days: 365 * 16),
                    ),
                  ),
                  _buildTextField(
                    _institutionalEmailController,
                    'Correo institucional',
                    keyboardType: TextInputType.emailAddress,
                    validator: validateEmail,
                  ),
                  _buildTextField(
                    _personalEmailController,
                    'Correo personal',
                    keyboardType: TextInputType.emailAddress,
                    validator: validateEmail,
                  ),
                  _buildTextField(
                    _phoneController,
                    'Numero celular',
                    keyboardType: TextInputType.phone,
                    validator: validatePhone,
                  ),
                  _buildTextField(
                    _emergencyContactController,
                    'Contacto de emergencia',
                  ),
                  _buildTextField(_relationshipController, 'Parentesco'),
                ],
              ),
            ),
            Step(
              isActive: _currentStep >= 1,
              title: const Text('Academica'),
              content: Column(
                children: [
                  _buildTextField(
                    _currentUniversityController,
                    'Universidad actual',
                  ),
                  _buildTextField(_facultyController, 'Facultad'),
                  _buildTextField(_programController, 'Programa academico'),
                  _buildTextField(
                    _currentSemesterController,
                    'Semestre actual',
                    keyboardType: TextInputType.number,
                    validator: validatePositiveNumber,
                  ),
                  _buildTextField(
                    _averageController,
                    'Promedio acumulado',
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    validator: validateAverage,
                  ),
                  _buildTextField(_languageLevelController, 'Nivel de idioma'),
                  _buildTextField(
                    _languageScoreController,
                    'Puntaje TOEFL / IELTS / DELF',
                  ),
                ],
              ),
            ),
            Step(
              isActive: _currentStep >= 2,
              title: const Text('Movilidad'),
              content: Column(
                children: [
                  _buildTextField(
                    _destinationUniversityController,
                    'Universidad destino',
                  ),
                  _buildTextField(_countryController, 'Pais'),
                  _buildTextField(_cityController, 'Ciudad'),
                  _buildTextField(
                    _destinationFacultyController,
                    'Facultad destino',
                  ),
                  _buildTextField(_studyAreaController, 'Area de estudio'),
                  _buildTextField(
                    _exchangeSemesterController,
                    'Semestre de intercambio',
                  ),
                  _DatePickerField(
                    controller: _travelDateController,
                    label: 'Fecha estimada de viaje',
                    onSelected: (value) {
                      _travelDate = value;
                    },
                    initialDate: _travelDate,
                    firstDate: DateTime.now().subtract(
                      const Duration(days: 30),
                    ),
                    lastDate: DateTime.now().add(const Duration(days: 365 * 3)),
                  ),
                  _DatePickerField(
                    controller: _returnDateController,
                    label: 'Fecha estimada de regreso',
                    onSelected: (value) {
                      _returnDate = value;
                    },
                    initialDate: _returnDate,
                    firstDate: DateTime.now().subtract(
                      const Duration(days: 30),
                    ),
                    lastDate: DateTime.now().add(const Duration(days: 365 * 4)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label, {
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        validator: validator ?? validateRequired,
        decoration: InputDecoration(labelText: label),
      ),
    );
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    if (_birthDate == null || _travelDate == null || _returnDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Completa todas las fechas requeridas.')),
      );
      return;
    }
    if (_returnDate!.isBefore(_travelDate!)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('La fecha de regreso debe ser posterior al viaje.'),
        ),
      );
      return;
    }

    final state = AppStateScope.of(context);
    final application = MobilityApplication(
      id: widget.existing?.id ?? '',
      userEmail: widget.currentUser.email,
      createdAt: widget.existing?.createdAt ?? DateTime.now(),
      firstName: _firstNameController.text.trim(),
      lastName: _lastNameController.text.trim(),
      documentType: _documentTypeController.text.trim(),
      documentNumber: _documentNumberController.text.trim(),
      birthDate: _birthDate!,
      institutionalEmail: _institutionalEmailController.text.trim(),
      personalEmail: _personalEmailController.text.trim(),
      phone: _phoneController.text.trim(),
      emergencyContact: _emergencyContactController.text.trim(),
      relationship: _relationshipController.text.trim(),
      currentUniversity: _currentUniversityController.text.trim(),
      faculty: _facultyController.text.trim(),
      program: _programController.text.trim(),
      currentSemester: int.parse(_currentSemesterController.text.trim()),
      average: double.parse(
        _averageController.text.trim().replaceAll(',', '.'),
      ),
      languageLevel: _languageLevelController.text.trim(),
      languageScore: _languageScoreController.text.trim(),
      destinationUniversity: _destinationUniversityController.text.trim(),
      country: _countryController.text.trim(),
      city: _cityController.text.trim(),
      destinationFaculty: _destinationFacultyController.text.trim(),
      studyArea: _studyAreaController.text.trim(),
      exchangeSemester: _exchangeSemesterController.text.trim(),
      travelDate: _travelDate!,
      returnDate: _returnDate!,
      status: widget.existing?.status ?? ApplicationStatus.pending,
      adminComment: widget.existing?.adminComment ?? '',
      rejectionReason: widget.existing?.rejectionReason ?? '',
    );

    if (widget.existing == null) {
      await state.createApplication(application);
    } else {
      await state.updateApplication(application);
    }

    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          widget.existing == null
              ? 'Solicitud creada exitosamente.'
              : 'Solicitud actualizada exitosamente.',
        ),
      ),
    );
    Navigator.of(context).pop();
  }
}

class _DatePickerField extends StatelessWidget {
  const _DatePickerField({
    required this.controller,
    required this.label,
    required this.onSelected,
    required this.firstDate,
    required this.lastDate,
    this.initialDate,
  });

  final TextEditingController controller;
  final String label;
  final ValueChanged<DateTime> onSelected;
  final DateTime firstDate;
  final DateTime lastDate;
  final DateTime? initialDate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextFormField(
        controller: controller,
        readOnly: true,
        validator: validateRequired,
        decoration: InputDecoration(
          labelText: label,
          suffixIcon: const Icon(Icons.calendar_today_outlined),
        ),
        onTap: () async {
          final picked = await showDatePicker(
            context: context,
            initialDate: initialDate ?? DateTime.now(),
            firstDate: firstDate,
            lastDate: lastDate,
          );
          if (picked != null) {
            controller.text = formatDate(picked);
            onSelected(picked);
          }
        },
      ),
    );
  }
}

class RequestSummaryCard extends StatelessWidget {
  const RequestSummaryCard({
    super.key,
    required this.application,
    this.onTap,
    this.subtitle,
  });

  final MobilityApplication application;
  final VoidCallback? onTap;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          application.studentName,
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          subtitle ??
                              '${application.destinationUniversity} · ${application.country}',
                          style: TextStyle(color: Colors.grey.shade700),
                        ),
                      ],
                    ),
                  ),
                  _StatusChip(status: application.status),
                ],
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  _MiniDataPill(
                    label: application.id,
                    icon: Icons.badge_outlined,
                  ),
                  _MiniDataPill(
                    label: formatDate(application.createdAt),
                    icon: Icons.event_outlined,
                  ),
                  _MiniDataPill(
                    label: application.exchangeSemester,
                    icon: Icons.school_outlined,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatusHeader extends StatelessWidget {
  const _StatusHeader({required this.application});

  final MobilityApplication application;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    application.studentName,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                _StatusChip(status: application.status),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              'Destino: ${application.destinationUniversity}, ${application.country}',
            ),
            if (application.adminComment.isNotEmpty) ...[
              const SizedBox(height: 12),
              Text(
                'Comentario administrativo: ${application.adminComment}',
                style: TextStyle(color: Colors.grey.shade800),
              ),
            ],
            if (application.rejectionReason.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                'Motivo de rechazo: ${application.rejectionReason}',
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.status});

  final ApplicationStatus status;

  @override
  Widget build(BuildContext context) {
    final color = status.color(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        status.label,
        style: TextStyle(color: color, fontWeight: FontWeight.w700),
      ),
    );
  }
}

class _MiniDataPill extends StatelessWidget {
  const _MiniDataPill({required this.label, required this.icon});

  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F7FB),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [Icon(icon, size: 18), const SizedBox(width: 8), Text(label)],
      ),
    );
  }
}

class _WelcomeBanner extends StatelessWidget {
  const _WelcomeBanner({required this.user, required this.onCreateRequest});

  final AppUser user;
  final VoidCallback onCreateRequest;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: LinearGradient(
          colors: [theme.colorScheme.primary, theme.colorScheme.secondary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hola, ${user.firstName}',
            style: theme.textTheme.headlineSmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Prepara tu proxima experiencia academica internacional con un flujo claro y ordenado.',
            style: TextStyle(color: Colors.white, height: 1.5),
          ),
          const SizedBox(height: 20),
          FilledButton.tonalIcon(
            style: FilledButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: theme.colorScheme.primary,
            ),
            onPressed: onCreateRequest,
            icon: const Icon(Icons.flight_takeoff_rounded),
            label: const Text('Crear nueva solicitud'),
          ),
        ],
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({
    required this.title,
    required this.value,
    required this.icon,
  });

  final String title;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 240,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Theme.of(
                    context,
                  ).colorScheme.primary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon),
              ),
              const SizedBox(height: 16),
              Text(
                value,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 4),
              Text(title),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatusChart extends StatelessWidget {
  const _StatusChart({required this.values});

  final Map<String, int> values;

  @override
  Widget build(BuildContext context) {
    final maxValue = values.values.fold<int>(
      1,
      (max, value) => value > max ? value : max,
    );
    final colors = [
      Colors.orange.shade400,
      Colors.green.shade400,
      Colors.red.shade400,
    ];

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: values.entries.toList().asMap().entries.map((entry) {
        final index = entry.key;
        final item = entry.value;
        final height = (item.value / maxValue) * 180;
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  '${item.value}',
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 10),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  height: height.clamp(28, 180),
                  decoration: BoxDecoration(
                    color: colors[index],
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                const SizedBox(height: 10),
                Text(item.key, textAlign: TextAlign.center),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _SkeletonList extends StatelessWidget {
  const _SkeletonList();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        3,
        (index) => Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Container(
            height: 120,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
            ),
            child: const LinearProgressIndicator(minHeight: 2),
          ),
        ),
      ),
    );
  }
}

class EmptyState extends StatelessWidget {
  const EmptyState({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    this.actionLabel,
    this.onAction,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          children: [
            Icon(icon, size: 52, color: Theme.of(context).colorScheme.primary),
            const SizedBox(height: 12),
            Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey.shade700),
            ),
            if (actionLabel != null && onAction != null) ...[
              const SizedBox(height: 18),
              FilledButton(onPressed: onAction, child: Text(actionLabel!)),
            ],
          ],
        ),
      ),
    );
  }
}

class _DetailSection extends StatelessWidget {
  const _DetailSection({required this.title, required this.rows});

  final String title;
  final List<MapEntry<String, String>> rows;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 16),
            ...rows.map(
              (row) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 150,
                      child: Text(
                        row.key,
                        style: TextStyle(color: Colors.grey.shade700),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        row.value,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

MapEntry<String, String> _detailRow(String label, String value) =>
    MapEntry<String, String>(label, value);

String? validateRequired(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'Este campo es obligatorio.';
  }
  return null;
}

String? validateEmail(String? value) {
  final required = validateRequired(value);
  if (required != null) {
    return required;
  }
  final regex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
  if (!regex.hasMatch(value!.trim())) {
    return 'Ingresa un correo valido.';
  }
  return null;
}

String? validatePassword(String? value) {
  final required = validateRequired(value);
  if (required != null) {
    return required;
  }
  if (value!.trim().length < 8) {
    return 'La contrasena debe tener minimo 8 caracteres.';
  }
  return null;
}

String? validatePhone(String? value) {
  final required = validateRequired(value);
  if (required != null) {
    return required;
  }
  final regex = RegExp(r'^\d{7,15}$');
  if (!regex.hasMatch(value!.trim())) {
    return 'Ingresa un numero valido.';
  }
  return null;
}

String? validatePositiveNumber(String? value) {
  final required = validateRequired(value);
  if (required != null) {
    return required;
  }
  final parsed = int.tryParse(value!.trim());
  if (parsed == null || parsed <= 0) {
    return 'Ingresa un numero valido.';
  }
  return null;
}

String? validateAverage(String? value) {
  final required = validateRequired(value);
  if (required != null) {
    return required;
  }
  final parsed = double.tryParse(value!.trim().replaceAll(',', '.'));
  if (parsed == null) {
    return 'Ingresa un promedio valido.';
  }
  if (parsed < 3.5) {
    return 'El promedio minimo es 3.5.';
  }
  return null;
}

String formatDate(DateTime date) {
  final day = date.day.toString().padLeft(2, '0');
  final month = date.month.toString().padLeft(2, '0');
  return '$day/$month/${date.year}';
}
