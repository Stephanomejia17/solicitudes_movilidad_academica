import 'package:flutter/material.dart';

import '../../../data/app_database.dart';
import '../../../shared/widgets/simple_entity_card.dart';

class StudentDashboardPage extends StatelessWidget {
  const StudentDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final db = AppStateScope.of(context);
    final user = db.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Estudiante'),
        actions: [
          IconButton(
            onPressed: db.logout,
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('Bienvenido ${user?.nombre ?? ''} ${user?.apellido ?? ''}'),
          const SizedBox(height: 16),
          StreamBuilder<List<SolicitudMobilidadData>>(
            stream: db.watchSolicitudesDeEstudiante(user?.id ?? ''),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              final solicitudes = snapshot.data!
                  .toList();
              if (solicitudes.isEmpty) {
                return const Text('No tienes solicitudes registradas.');
              }
              return Column(
                children: solicitudes
                    .map(
                      (s) => SimpleEntityCard(
                        title: s.programaAcademico,
                        subtitle: '${s.estado} - ${s.tipoMovilidad}',
                      ),
                    )
                    .toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}
