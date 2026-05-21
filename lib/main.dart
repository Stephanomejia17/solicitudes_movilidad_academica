library;

import 'package:flutter/material.dart';
import 'package:solicitudes_movilidad_academica/data/app_database.dart';
import 'package:solicitudes_movilidad_academica/model/record_model.dart';

part 'pages/admin_pages.dart';
part 'pages/application_form_page.dart';
part 'pages/auth_pages.dart';
part 'pages/student_pages.dart';
part 'services/app_theme.dart';
part 'services/form_utils.dart';
part 'widgets/auth_widgets.dart';
part 'widgets/dashboard_widgets.dart';
part 'widgets/detail_widgets.dart';
part 'widgets/feedback_widgets.dart';
part 'widgets/form_widgets.dart';
part 'widgets/request_widgets.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppDatabase _state = AppDatabase();

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
