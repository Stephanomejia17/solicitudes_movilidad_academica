part of '../main.dart';

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
