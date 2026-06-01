import 'package:flutter/material.dart';

import 'data/app_database.dart';
import 'features/admin/pages/admin_dashboard_page.dart';
import 'features/auth/pages/auth_page.dart';
import 'features/coordinator/pages/coordinator_dashboard_page.dart';
import 'features/student/pages/student_dashboard_page.dart';
import 'shared/services/app_theme.dart';

void main() {
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

