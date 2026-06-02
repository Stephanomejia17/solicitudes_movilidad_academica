import 'package:flutter/material.dart';

import '../../../data/app_database.dart';
import '../services/admin_repository.dart';

class UserFormDialog extends StatefulWidget {
  const UserFormDialog({
    super.key,
    this.usuario,
    required this.repository,
    required this.currentUser,
  });

  final UsuarioData? usuario;
  final AdminRepository repository;
  final UsuarioData currentUser;

  @override
  State<UserFormDialog> createState() => _UserFormDialogState();
}

class _UserFormDialogState extends State<UserFormDialog> {
  late TextEditingController _nombreController;
  late TextEditingController _apellidoController;
  late TextEditingController _emailController;
  late TextEditingController _contrasenaController;
  late String _rolSeleccionado;
  bool _isLoading = false;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _nombreController = TextEditingController(text: widget.usuario?.nombre ?? '');
    _apellidoController =
        TextEditingController(text: widget.usuario?.apellido ?? '');
    _emailController = TextEditingController(text: widget.usuario?.email ?? '');
    _contrasenaController = TextEditingController();
    _rolSeleccionado = widget.usuario?.rol ?? 'estudiante';
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _apellidoController.dispose();
    _emailController.dispose();
    _contrasenaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.usuario != null;

    return AlertDialog(
      title: Text(isEditing ? 'Editar usuario' : 'Crear usuario'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nombreController,
                decoration: const InputDecoration(
                  labelText: 'Nombre',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Nombre requerido' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _apellidoController,
                decoration: const InputDecoration(
                  labelText: 'Apellido',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Apellido requerido' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) return 'Email requerido';
                  if (!value!.contains('@')) return 'Email inválido';
                  return null;
                },
              ),
              if (!isEditing) ...[
                const SizedBox(height: 12),
                TextFormField(
                  controller: _contrasenaController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Contraseña',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Contraseña requerida';
                    if (value.length < 6) return 'Mínimo 6 caracteres';
                    return null;
                  },
                ),
              ],
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: _rolSeleccionado,
                decoration: const InputDecoration(
                  labelText: 'Rol',
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(value: 'estudiante', child: Text('Estudiante')),
                  DropdownMenuItem(value: 'coordinador', child: Text('Coordinador')),
                  DropdownMenuItem(
                    value: 'administrador',
                    child: Text('Administrador'),
                  ),
                ]
                    .map(
                      (item) => DropdownMenuItem(
                        value: item.value,
                        child: item.child,
                      ),
                    )
                    .toList(),
                onChanged: (value) => setState(() => _rolSeleccionado = value!),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isLoading ? null : () => Navigator.pop(context),
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: _isLoading ? null : _guardar,
          child: _isLoading
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('Guardar'),
        ),
      ],
    );
  }

  Future<void> _guardar() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final nombre = _nombreController.text.trim();
      final apellido = _apellidoController.text.trim();
      final email = _emailController.text.trim().toLowerCase();
      final contrasena = _contrasenaController.text.trim();

      if (widget.usuario == null) {
        // Crear nuevo usuario (contraseña obligatoria)
        await widget.repository.crearUsuario(
          nombre: nombre,
          apellido: apellido,
          email: email,
          rol: _rolSeleccionado,
          contrasena: contrasena,
          createdBy: widget.currentUser.id,
        );
      } else {
        // Editar usuario existente
        await widget.repository.editarUsuario(
          id: widget.usuario!.id,
          nombre: nombre,
          apellido: apellido,
          email: email,
          rol: _rolSeleccionado,
        );
      }

      if (mounted) {
        Navigator.pop(context, true);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              widget.usuario == null ? 'Usuario creado' : 'Usuario actualizado',
            ),
            backgroundColor: Colors.green,
          ),
        );
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
}
