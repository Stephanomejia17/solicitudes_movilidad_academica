part of '../../../main.dart';

class CoordinatorHomePage extends StatefulWidget {
  const CoordinatorHomePage({super.key});

  @override
  State<CoordinatorHomePage> createState() => _CoordinatorHomePageState();
}

class _CoordinatorHomePageState extends State<CoordinatorHomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final state = AppStateScope.of(context);
    final pages = const [
      CoordinatorDashboard(),
      CoordinatorRequestsList(status: RequestStatus.submitted),
      CoordinatorRequestsList(status: RequestStatus.approved),
      CoordinatorRequestsList(status: RequestStatus.rejected),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Panel coordinador'),
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

class CoordinatorDashboard extends StatelessWidget {
  const CoordinatorDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final state = AppStateScope.of(context);
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Text(
          'Revision de movilidad',
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
                    'Pendientes': state.countByStatus(RequestStatus.submitted),
                    'Aprobadas': state.countByStatus(RequestStatus.approved),
                    'Rechazadas': state.countByStatus(RequestStatus.rejected),
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

class CoordinatorRequestsList extends StatelessWidget {
  const CoordinatorRequestsList({super.key, required this.status});

  final RequestStatus status;

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
                      builder: (_) => CoordinatorRequestReviewPage(
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

class CoordinatorRequestReviewPage extends StatefulWidget {
  const CoordinatorRequestReviewPage({super.key, required this.applicationId});

  final String applicationId;

  @override
  State<CoordinatorRequestReviewPage> createState() =>
      _CoordinatorRequestReviewPageState();
}

class _CoordinatorRequestReviewPageState
    extends State<CoordinatorRequestReviewPage> {
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
    final user = state.currentUser!;
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
                      labelText: 'Comentario del coordinador',
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
          const SizedBox(height: 16),
          RequestHistorySection(
            entries: state.historyForRequest(application.id),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed:
                    const RequestWorkflowService().canReview(user, application)
                    ? () => _review(
                        status: RequestStatus.rejected,
                        requireReason: true,
                      )
                    : null,
                icon: const Icon(Icons.close_rounded),
                label: const Text('Rechazar'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: FilledButton.icon(
                onPressed:
                    const RequestWorkflowService().canReview(user, application)
                    ? () => _review(
                        status: RequestStatus.approved,
                        requireReason: false,
                      )
                    : null,
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
    required RequestStatus status,
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
      SnackBar(content: Text('Solicitud revisada correctamente.')),
    );
    Navigator.of(context).pop();
  }
}
