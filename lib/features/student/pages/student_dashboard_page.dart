import 'package:flutter/material.dart';

import '../../../data/app_database.dart';
import '../../auth/services/auth_service.dart';
import '../services/student_application_repository.dart';
import '../widgets/student_dashboard_widgets.dart';
import 'student_application_detail_page.dart';
import 'student_application_form_page.dart';

class StudentDashboardPage extends StatefulWidget {
  const StudentDashboardPage({super.key});

  @override
  State<StudentDashboardPage> createState() => _StudentDashboardPageState();
}

class _StudentDashboardPageState extends State<StudentDashboardPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final db = AppStateScope.of(context);
    final authService = AuthServiceScope.of(context);
    final user = db.currentUser!;
    final repository = StudentApplicationRepository(database: db);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Portal estudiante'),
        actions: [
          IconButton(
            tooltip: 'Sincronizar',
            onPressed: repository.syncPending,
            icon: const Icon(Icons.cloud_sync_outlined),
          ),
          IconButton(
            tooltip: 'Cerrar sesion',
            onPressed: authService.logout,
            icon: const Icon(Icons.logout_rounded),
          ),
        ],
      ),
      body: StreamBuilder<List<SolicitudMobilidadData>>(
        stream: repository.watchMine(user.id),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final solicitudes = snapshot.data!;
          final pages = [
            _StudentDashboard(
              user: user,
              solicitudes: solicitudes,
              onCreateRequest: () => _openForm(context, user),
              onOpenRequest: (solicitud) => _openDetail(context, solicitud.id),
            ),
            _StudentRequestsPage(
              solicitudes: solicitudes,
              onCreateRequest: () => _openForm(context, user),
              onOpenRequest: (solicitud) => _openDetail(context, solicitud.id),
            ),
          ];

          return IndexedStack(index: _currentIndex, children: pages);
        },
      ),
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
        onPressed: () => _openForm(context, user),
        icon: const Icon(Icons.add_rounded),
        label: const Text('Nueva solicitud'),
      ),
    );
  }

  Future<void> _openForm(BuildContext context, UsuarioData user) async {
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => StudentApplicationFormPage(user: user),
      ),
    );
  }

  Future<void> _openDetail(BuildContext context, String id) async {
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => StudentApplicationDetailPage(applicationId: id),
      ),
    );
  }
}

class _StudentDashboard extends StatelessWidget {
  const _StudentDashboard({
    required this.user,
    required this.solicitudes,
    required this.onCreateRequest,
    required this.onOpenRequest,
  });

  final UsuarioData user;
  final List<SolicitudMobilidadData> solicitudes;
  final VoidCallback onCreateRequest;
  final ValueChanged<SolicitudMobilidadData> onOpenRequest;

  @override
  Widget build(BuildContext context) {
    final borradores = solicitudes.where((item) => item.estado == 'borrador');
    final aprobadas = solicitudes.where((item) => item.estado == 'aprobada');

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        WelcomeBanner(user: user, onCreateRequest: onCreateRequest),
        const SizedBox(height: 20),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            StatCard(
              title: 'Total solicitudes',
              value: '${solicitudes.length}',
              icon: Icons.folder_copy_outlined,
            ),
            StatCard(
              title: 'Borradores',
              value: '${borradores.length}',
              icon: Icons.edit_document,
            ),
            StatCard(
              title: 'Aprobadas',
              value: '${aprobadas.length}',
              icon: Icons.check_circle_outline_rounded,
            ),
          ],
        ),
        const SizedBox(height: 24),
        Text(
          'Historial reciente',
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 12),
        if (solicitudes.isEmpty)
          EmptyState(
            title: 'Aun no tienes solicitudes',
            subtitle:
                'Crea tu primera solicitud de intercambio para empezar el proceso.',
            icon: Icons.inbox_outlined,
            actionLabel: 'Nueva solicitud',
            onAction: onCreateRequest,
          )
        else
          ...solicitudes
              .take(3)
              .map(
                (solicitud) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: RequestSummaryCard(
                    solicitud: solicitud,
                    onTap: () => onOpenRequest(solicitud),
                  ),
                ),
              ),
      ],
    );
  }
}

class _StudentRequestsPage extends StatelessWidget {
  const _StudentRequestsPage({
    required this.solicitudes,
    required this.onCreateRequest,
    required this.onOpenRequest,
  });

  final List<SolicitudMobilidadData> solicitudes;
  final VoidCallback onCreateRequest;
  final ValueChanged<SolicitudMobilidadData> onOpenRequest;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        if (solicitudes.isEmpty)
          EmptyState(
            title: 'No hay solicitudes registradas',
            subtitle: 'Usa el boton inferior para crear una nueva solicitud.',
            icon: Icons.edit_document,
            actionLabel: 'Nueva solicitud',
            onAction: onCreateRequest,
          )
        else
          ...solicitudes.map(
            (solicitud) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: RequestSummaryCard(
                solicitud: solicitud,
                onTap: () => onOpenRequest(solicitud),
              ),
            ),
          ),
      ],
    );
  }
}
