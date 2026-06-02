import 'package:flutter/material.dart';

import '../../../data/app_database.dart';
import '../../auth/services/auth_service.dart';
import '../services/admin_repository.dart';
import '../widgets/user_card.dart';
import '../widgets/user_form_dialog.dart';

class AdminDashboardPage extends StatefulWidget {
  const AdminDashboardPage({super.key});

  @override
  State<AdminDashboardPage> createState() => _AdminDashboardPageState();
}

class _AdminDashboardPageState extends State<AdminDashboardPage> {
  bool _isSyncing = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeData();
    });
  }

  Future<void> _initializeData() async {
    final db = AppStateScope.of(context);
    final repository = AdminRepository(database: db);
    final currentUser = db.currentUser;
    if (currentUser != null) {
      await repository.sincronizarDesdeFirestore(currentUser.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    final db = AppStateScope.of(context);
    final authService = AuthServiceScope.of(context);
    final currentUser = db.currentUser!;
    final repository = AdminRepository(database: db);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Administrador'),
        actions: [
          IconButton(
            tooltip: 'Sincronizar',
            onPressed: _isSyncing ? null : () => _syncData(repository),
            icon: _isSyncing
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : const Icon(Icons.cloud_sync_outlined),
          ),
          IconButton(
            onPressed: authService.logout,
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: StreamBuilder<List<UsuarioData>>(
        stream: repository.watchUsuarios(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final usuarios = snapshot.data!;
          
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Gestión de usuarios',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: Text('Total: ${usuarios.length} usuarios'),
                          ),
                          ElevatedButton.icon(
                            onPressed: () => _crearUsuario(context, repository, currentUser),
                            icon: const Icon(Icons.add),
                            label: const Text('Nuevo usuario'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ...usuarios.map(
                (usuario) => UserCard(
                  usuario: usuario,
                  repository: repository,
                  currentUser: currentUser,
                  onStatusChanged: () => setState(() {}),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _crearUsuario(
    BuildContext context,
    AdminRepository repository,
    UsuarioData currentUser,
  ) {
    showDialog(
      context: context,
      builder: (context) => UserFormDialog(
        repository: repository,
        currentUser: currentUser,
      ),
    ).then((result) {
      if (result == true) {
        setState(() {});
      }
    });
  }

  Future<void> _syncData(AdminRepository repository) async {
    setState(() => _isSyncing = true);

    try {
      await repository.syncPending();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Datos sincronizados correctamente'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error en sincronización: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSyncing = false);
      }
    }
  }
}
