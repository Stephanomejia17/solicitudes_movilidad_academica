import 'package:flutter/material.dart';

import '../../../data/app_database.dart';
import '../../../shared/widgets/simple_entity_card.dart';

class AdminDashboardPage extends StatelessWidget {
  const AdminDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final db = AppStateScope.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Administrador'),
        actions: [
          IconButton(
            onPressed: db.logout,
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: StreamBuilder<List<UsuarioData>>(
        stream: db.watchUsuarios(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final usuarios = snapshot.data!;
          return ListView(
            padding: const EdgeInsets.all(16),
            children: usuarios
                .map(
                  (u) => SimpleEntityCard(
                    title: '${u.nombre} ${u.apellido}',
                    subtitle: '${u.email} - ${u.rol} - ${u.estado}',
                    trailing: Switch(
                      value: u.estado == 'activo',
                      onChanged: (value) async {
                        await db.setUsuarioEstado(
                          u.id,
                          value ? 'activo' : 'inactivo',
                        );
                      },
                    ),
                  ),
                )
                .toList(),
          );
        },
      ),
    );
  }
}
