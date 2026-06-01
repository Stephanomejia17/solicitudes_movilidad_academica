import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'data/app_database.dart';
import 'features/admin/pages/admin_dashboard_page.dart';
import 'features/auth/pages/auth_page.dart';
import 'features/coordinator/pages/coordinator_dashboard_page.dart';
import 'features/student/pages/student_dashboard_page.dart';
import 'firebase_options.dart';
import 'shared/services/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb ||
      defaultTargetPlatform == TargetPlatform.android ||
      defaultTargetPlatform == TargetPlatform.iOS ||
      defaultTargetPlatform == TargetPlatform.macOS ||
      defaultTargetPlatform == TargetPlatform.windows) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppDatabase _database = AppDatabase();

  @override
  Widget build(BuildContext context) {
    return AppStateScope(
      state: _database,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Movilidad Academica',
        theme: buildAppTheme(),
        home: const RootView(),
      ),
    );
  }
}

class RootView extends StatelessWidget {
  const RootView({super.key});

  @override
  Widget build(BuildContext context) {
    final db = AppStateScope.of(context);
    final user = db.currentUser;

    if (user == null) {
      return const AuthPage();
    }

    switch (user.rol) {
      case 'administrador':
        return const AdminDashboardPage();
      case 'coordinador':
        return const CoordinatorDashboardPage();
      default:
        return const StudentDashboardPage();
    }
  }
}
