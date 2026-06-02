import 'dart:async';

import 'package:flutter/material.dart';

import '../../../data/app_database.dart';
import '../../auth/services/auth_service.dart';
import '../services/coordinator_repository.dart';
import 'coordinator_solicitud_detail_page.dart';

class CoordinatorDashboardPage extends StatefulWidget {
  const CoordinatorDashboardPage({super.key});

  @override
  State<CoordinatorDashboardPage> createState() =>
      _CoordinatorDashboardPageState();
}

class _CoordinatorDashboardPageState extends State<CoordinatorDashboardPage> {
  late CoordinatorRepository _repository;
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initialized) return;
    _initialized = true;
    _repository = CoordinatorRepository(database: AppStateScope.of(context));
    // Local data is rendered immediately; remote sync is attempted in the background.
    unawaited(_repository.syncPending());
  }

  @override
  Widget build(BuildContext context) {
    final authService = AuthServiceScope.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Coordinador'),
        actions: [
          IconButton(
            tooltip: 'Sincronizar',
            onPressed: () => _repository.syncPending(),
            icon: const Icon(Icons.sync),
          ),
          IconButton(
            tooltip: 'Cerrar sesion',
            onPressed: () => authService.logout(),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: StreamBuilder<List<SolicitudMobilidadData>>(
        stream: _repository.watchSolicitudes(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final solicitudes = snapshot.data!;
          final counts = _DashboardCounts.fromSolicitudes(solicitudes);

          return DefaultTabController(
            length: 4,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Resumen operativo',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w800,
                            ),
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 12,
                        children: [
                          _StatCard(
                            label: 'Total',
                            value: counts.total,
                            icon: Icons.folder_copy_outlined,
                          ),
                          _StatCard(
                            label: 'Pendientes',
                            value: counts.pending,
                            icon: Icons.hourglass_top_outlined,
                          ),
                          _StatCard(
                            label: 'Aprobadas',
                            value: counts.approved,
                            icon: Icons.verified_outlined,
                          ),
                          _StatCard(
                            label: 'Rechazadas',
                            value: counts.rejected,
                            icon: Icons.cancel_outlined,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const TabBar(
                  isScrollable: true,
                  tabs: [
                    Tab(text: 'Todas'),
                    Tab(text: 'En revision'),
                    Tab(text: 'Aprobadas'),
                    Tab(text: 'Rechazadas'),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      _SolicitudList(
                        solicitudes: solicitudes,
                        onOpen: (item) => _openDetail(context, item.id),
                      ),
                      _SolicitudList(
                        solicitudes: solicitudes
                            .where((item) => item.estado == 'enviada')
                            .toList(),
                        emptyLabel: 'No hay solicitudes pendientes de revision.',
                        onOpen: (item) => _openDetail(context, item.id),
                      ),
                      _SolicitudList(
                        solicitudes: solicitudes
                            .where((item) => item.estado == 'aprobada')
                            .toList(),
                        emptyLabel: 'No hay solicitudes aprobadas todavia.',
                        onOpen: (item) => _openDetail(context, item.id),
                      ),
                      _SolicitudList(
                        solicitudes: solicitudes
                            .where((item) => item.estado == 'rechazada')
                            .toList(),
                        emptyLabel: 'No hay solicitudes rechazadas todavia.',
                        onOpen: (item) => _openDetail(context, item.id),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> _openDetail(BuildContext context, String solicitudId) async {
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => CoordinatorSolicitudDetailPage(solicitudId: solicitudId),
      ),
    );
  }
}

class _DashboardCounts {
  const _DashboardCounts({
    required this.total,
    required this.pending,
    required this.approved,
    required this.rejected,
  });

  final int total;
  final int pending;
  final int approved;
  final int rejected;

  factory _DashboardCounts.fromSolicitudes(
    List<SolicitudMobilidadData> solicitudes,
  ) {
    return _DashboardCounts(
      total: solicitudes.length,
      pending: solicitudes.where((item) => item.estado == 'enviada').length,
      approved: solicitudes.where((item) => item.estado == 'aprobada').length,
      rejected: solicitudes.where((item) => item.estado == 'rechazada').length,
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.label,
    required this.value,
    required this.icon,
  });

  final String label;
  final int value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 150),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(icon, size: 16),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$value',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.w900,
                          ),
                    ),
                    Text(label, overflow: TextOverflow.ellipsis),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SolicitudList extends StatelessWidget {
  const _SolicitudList({
    required this.solicitudes,
    required this.onOpen,
    this.emptyLabel = 'No hay solicitudes para mostrar.',
  });

  final List<SolicitudMobilidadData> solicitudes;
  final ValueChanged<SolicitudMobilidadData> onOpen;
  final String emptyLabel;

  @override
  Widget build(BuildContext context) {
    if (solicitudes.isEmpty) {
      return Center(
        child: Text(
          emptyLabel,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: solicitudes.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        final item = solicitudes[index];
        return Card(
          child: ListTile(
            onTap: () => onOpen(item),
            title: Text(item.programaAcademico),
            subtitle: Text(
              '${item.nombres} ${item.apellidos}\n${item.estado} • ${item.universidadDestinoNombre}',
            ),
            isThreeLine: true,
            trailing: _StatusChip(status: item.estado),
          ),
        );
      },
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.status});

  final String status;

  @override
  Widget build(BuildContext context) {
    final (color, label) = switch (status) {
      'enviada' => (Colors.orange, 'En revision'),
      'aprobada' => (Colors.green, 'Aprobada'),
      'rechazada' => (Colors.red, 'Rechazada'),
      _ => (Colors.blueGrey, 'Borrador'),
    };

    return Chip(
      label: Text(label),
      backgroundColor: color.withOpacity(0.12),
      side: BorderSide(color: color.withOpacity(0.35)),
      labelStyle: TextStyle(color: color, fontWeight: FontWeight.w700),
    );
  }
}
