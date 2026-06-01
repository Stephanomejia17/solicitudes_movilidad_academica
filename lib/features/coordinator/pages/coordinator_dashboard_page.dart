import 'package:flutter/material.dart';

import '../../../data/app_database.dart';
import '../../../shared/widgets/simple_entity_card.dart';

class CoordinatorDashboardPage extends StatelessWidget {
  const CoordinatorDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final db = AppStateScope.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Coordinador'),
        actions: [
          IconButton(
            onPressed: db.logout,
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: StreamBuilder<List<SolicitudMobilidadData>>(
        stream: db.watchSolicitudes(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final solicitudes = snapshot.data!;
          return ListView(
            padding: const EdgeInsets.all(16),
            children: solicitudes
                .map(
                  (s) => SimpleEntityCard(
                    title: s.programaAcademico,
                    subtitle: s.estado,
                  ),
                )
                .toList(),
          );
        },
      ),
    );
  }
}
