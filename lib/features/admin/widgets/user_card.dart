import 'package:flutter/material.dart';

import '../../../data/app_database.dart';
import '../services/admin_repository.dart';
import 'user_form_dialog.dart';

class UserCard extends StatefulWidget {
  const UserCard({
    super.key,
    required this.usuario,
    required this.repository,
    required this.currentUser,
    this.onStatusChanged,
  });

  final UsuarioData usuario;
  final AdminRepository repository;
  final UsuarioData currentUser;
  final VoidCallback? onStatusChanged;

  @override
  State<UserCard> createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final usuario = widget.usuario;
    final esActivo = usuario.estado == 'activo';

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        title: Text('${usuario.nombre} ${usuario.apellido}'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(usuario.email),
            const SizedBox(height: 4),
            Wrap(
              spacing: 8,
              children: [
                Chip(
                  label: Text(usuario.rol),
                  side: BorderSide.none,
                  visualDensity: VisitualDensityCompact,
                ),
                Chip(
                  label: Text(usuario.estado),
                  side: BorderSide.none,
                  visualDensity: VisitualDensityCompact,
                ),
              ],
            ),
          ],
        ),
        isThreeLine: true,
        trailing: _isLoading
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : PopupMenuButton<String>(
                onSelected: (action) => _handleAction(context, action),
                itemBuilder: (BuildContext context) => [
                  const PopupMenuItem(
                    value: 'edit',
                    child: Text('Editar'),
                  ),
                  if (esActivo)
                    const PopupMenuItem(
                      value: 'deactivate',
                      child: Text('Desactivar'),
                    )
                  else
                    const PopupMenuItem(
                      value: 'activate',
                      child: Text('Activar'),
                    ),
                  const PopupMenuItem(
                    value: 'history',
                    child: Text('Ver historial'),
                  ),
                ],
              ),
      ),
    );
  }

  Future<void> _handleAction(BuildContext context, String action) async {
    switch (action) {
      case 'edit':
        _editUsuario(context);
        break;
      case 'activate':
        _cambiarEstado(context, 'activo');
        break;
      case 'deactivate':
        _cambiarEstado(context, 'inactivo');
        break;
      case 'history':
        _verHistorial(context);
        break;
    }
  }

  void _editUsuario(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => UserFormDialog(
        usuario: widget.usuario,
        repository: widget.repository,
        currentUser: widget.currentUser,
      ),
    ).then((result) {
      if (result == true) {
        widget.onStatusChanged?.call();
      }
    });
  }

  Future<void> _cambiarEstado(BuildContext context, String nuevoEstado) async {
    final confirmacion = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar'),
        content: Text(
          '¿Deseas cambiar el estado a $nuevoEstado?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Confirmar'),
          ),
        ],
      ),
    );

    if (confirmacion != true) return;

    setState(() => _isLoading = true);

    try {
      await widget.repository.cambiarEstadoUsuario(
        id: widget.usuario.id,
        nuevoEstado: nuevoEstado,
        comentario: 'Estado cambiado a $nuevoEstado',
        registradoPor: widget.currentUser.id,
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Estado actualizado a $nuevoEstado'),
            backgroundColor: Colors.green,
          ),
        );
        widget.onStatusChanged?.call();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _verHistorial(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => _HistorialDialog(
        usuarioId: widget.usuario.id,
        repository: widget.repository,
      ),
    );
  }
}

class _HistorialDialog extends StatelessWidget {
  const _HistorialDialog({
    required this.usuarioId,
    required this.repository,
  });

  final String usuarioId;
  final AdminRepository repository;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Historial de cambios'),
      content: SizedBox(
        width: double.maxFinite,
        child: StreamBuilder<List<HistorialEstadoData>>(
          stream: repository.watchHistorialUsuario(usuarioId),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final historial = snapshot.data!;

            if (historial.isEmpty) {
              return const Center(
                child: Text('No hay cambios registrados'),
              );
            }

            return ListView.builder(
              itemCount: historial.length,
              itemBuilder: (context, index) {
                final registro = historial[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${registro.estadoAnterior} → ${registro.estadoNuevo}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      if (registro.comentario != null)
                        Text(registro.comentario!),
                      Text(
                        registro.fechaCambio.toString().split('.')[0],
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const Divider(),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cerrar'),
        ),
      ],
    );
  }
}

const VisitualDensityCompact = VisualDensity(horizontal: -4, vertical: -4);
