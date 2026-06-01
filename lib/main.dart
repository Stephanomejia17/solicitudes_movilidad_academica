library;

import 'package:flutter/material.dart';
import 'package:solicitudes_movilidad_academica/data/app_database.dart';
import 'package:solicitudes_movilidad_academica/model/record_model.dart';
import 'package:solicitudes_movilidad_academica/shared/services/access_policy.dart';
import 'package:solicitudes_movilidad_academica/shared/services/request_workflow_service.dart';

part 'features/admin/pages/admin_pages.dart';
part 'features/auth/pages/auth_pages.dart';
part 'features/auth/widgets/auth_widgets.dart';
part 'features/coordinator/pages/coordinator_pages.dart';
part 'features/student/pages/application_form_page.dart';
part 'features/student/pages/student_pages.dart';
part 'shared/services/app_theme.dart';
part 'shared/services/form_utils.dart';
part 'shared/widgets/dashboard_widgets.dart';
part 'shared/widgets/detail_widgets.dart';
part 'shared/widgets/feedback_widgets.dart';
part 'shared/widgets/form_widgets.dart';
part 'shared/widgets/request_widgets.dart';

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

    const accessPolicy = AccessPolicy();
    if (accessPolicy.canOpenAdminArea(user)) {
      return const AdminHomePage();
    }
    if (accessPolicy.canOpenCoordinatorArea(user)) {
      return const CoordinatorHomePage();
    }
    return const StudentHomePage();
  }
}
