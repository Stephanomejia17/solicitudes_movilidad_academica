import 'dart:async';

import 'package:flutter/material.dart';

import '../../../data/app_database.dart';
import '../../auth/services/auth_service.dart';
import '../services/coordinator_repository.dart';
import 'coordinator_solicitud_detail_page.dart';

class CoordinatorDashboardPage extends StatefulWidget {
  const CoordinatorDashboardPage({
    super.key,
    this.repository,
    this.authService,
  });

  final CoordinatorRepository? repository;
  final AuthService? authService;

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
    _repository = widget.repository ?? CoordinatorRepository(database: AppStateScope.of(context));
    
    unawaited(_repository.syncPending());
  }

  @override
  Widget build(BuildContext context) {
    final authService = widget.authService ?? AuthServiceScope.of(context);

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
          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error al cargar solicitudes',
              ),
            );
          }

          if (!snapshot.hasData) {
            return Center(
              child: Text(
                'No hay solicitudes para mostrar',
              ),
            );
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
                            accentColor: Colors.blueGrey,
                          ),
                          _StatCard(
                            label: 'Pendientes',
                            value: counts.pending,
                            icon: Icons.hourglass_top_outlined,
                            accentColor: Colors.orange,
                          ),
                          _StatCard(
                            label: 'Aprobadas',
                            value: counts.approved,
                            icon: Icons.verified_outlined,
                            accentColor: Colors.green,
                          ),
                          _StatCard(
                            label: 'Rechazadas',
                            value: counts.rejected,
                            icon: Icons.cancel_outlined,
                            accentColor: const Color.fromARGB(255, 255, 91, 79),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const TabBar(
                  isScrollable: true,
                  tabs: [
                    Tab(text: ' Todas'),
                    Tab(text: ' En revision'),
                    Tab(text: ' Aprobadas'),
                    Tab(text: ' Rechazadas'),
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
        builder: (_) => CoordinatorSolicitudDetailPage(
          solicitudId: solicitudId,
          repository: _repository,
        ),
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
    required this.accentColor,
  });

  final String label;
  final int value;
  final IconData icon;
  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 150),
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 105, 105, 105),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: accentColor.withOpacity(0.3),
            width: 1.2,
          ),
        ),
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: accentColor.withOpacity(0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, size: 18, color: accentColor),
            ),
            const SizedBox(height: 16),
            Text(
              '$value',
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w800,
                color: Colors.white,
                letterSpacing: -1.5,
                height: 1,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                color: Colors.white.withOpacity(0.5),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
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
