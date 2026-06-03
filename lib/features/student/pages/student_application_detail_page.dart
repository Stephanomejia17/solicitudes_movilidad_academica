import 'package:flutter/material.dart';

import '../../../data/app_database.dart';
import '../services/student_application_repository.dart';
import '../widgets/student_dashboard_widgets.dart';
import 'student_application_form_page.dart';

class StudentApplicationDetailPage extends StatelessWidget {
  const StudentApplicationDetailPage({super.key, required this.applicationId});

  final String applicationId;

  @override
  Widget build(BuildContext context) {
    final db = AppStateScope.of(context);
    final repository = StudentApplicationRepository(database: db);
    final user = db.currentUser!;

    return StreamBuilder<List<SolicitudMobilidadData>>(
      stream: repository.watchMine(user.id),
      builder: (context, snapshot) {
        final solicitud = snapshot.data
            ?.where((item) => item.id == applicationId)
            .firstOrNull;

        if (!snapshot.hasData) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (solicitud == null) {
          return Scaffold(
            appBar: AppBar(title: const Text('Solicitud')),
            body: const Center(child: Text('Solicitud no encontrada.')),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: Text('Solicitud ${solicitud.id.substring(0, 8)}'),
          ),
          body: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              _StatusHeader(solicitud: solicitud),
              const SizedBox(height: 16),
              DetailSection(
                title: 'Informacion personal',
                rows: [
                  detailRow('Nombres', solicitud.nombres),
                  detailRow('Apellidos', solicitud.apellidos),
                  detailRow(
                    'Documento',
                    '${solicitud.tipoDocumento} ${solicitud.numeroDocumento}',
                  ),
                  detailRow(
                    'Nacimiento',
                    formatStudentDate(solicitud.fechaNacimiento),
                  ),
                  detailRow('Correo inst.', solicitud.emailInstitucional),
                  detailRow('Correo personal', solicitud.emailPersonal),
                  detailRow('Celular', solicitud.telefono),
                  detailRow('Emergencia', solicitud.contactoEmergencia),
                  detailRow('Parentesco', solicitud.relacionContacto),
                ],
              ),
              const SizedBox(height: 16),
              DetailSection(
                title: 'Informacion academica',
                rows: [
                  detailRow('Universidad actual', solicitud.universidadActual),
                  detailRow('Facultad', solicitud.facultad),
                  detailRow('Programa', solicitud.programaAcademico),
                  detailRow('Semestre', '${solicitud.semestre}'),
                  detailRow(
                    'Promedio',
                    solicitud.promedioAcumulado.toStringAsFixed(1),
                  ),
                  detailRow('Nivel idioma', solicitud.nivelIdioma),
                  detailRow('Puntaje', solicitud.puntajeIdioma),
                ],
              ),
              const SizedBox(height: 16),
              DetailSection(
                title: 'Movilidad',
                rows: [
                  detailRow('Tipo', solicitud.tipoMovilidad),
                  detailRow(
                    'Universidad destino',
                    solicitud.universidadDestinoNombre,
                  ),
                  detailRow('Pais', solicitud.paisDestino),
                  detailRow('Ciudad', solicitud.ciudadDestino),
                  detailRow('Facultad destino', solicitud.facultadDestino),
                  detailRow('Area de estudio', solicitud.areaEstudio),
                  detailRow(
                    'Semestre intercambio',
                    solicitud.semestreIntercambio,
                  ),
                  detailRow(
                    'Viaje estimado',
                    formatStudentDate(solicitud.fechaViaje),
                  ),
                  detailRow(
                    'Regreso estimado',
                    formatStudentDate(solicitud.fechaRegreso),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _DocumentsSection(repository: repository, solicitud: solicitud),
              const SizedBox(height: 16),
              _HistorySection(
                repository: repository,
                solicitudId: solicitud.id,
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
                        solicitud.estado == 'borrador' && !solicitud.bloqueada
                        ? () {
                            Navigator.of(context).push(
                              MaterialPageRoute<String>(
                                builder: (_) => StudentApplicationFormPage(
                                  user: user,
                                  existing: solicitud,
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
                  child: FilledButton.icon(
                    onPressed:
                        solicitud.estado == 'borrador' && !solicitud.bloqueada
                        ? () async {
                            try {
                              await repository.submit(solicitud.id, user);
                              if (!context.mounted) return;
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Solicitud enviada.'),
                                ),
                              );
                              Navigator.of(context).pop();
                            } catch (error) {
                              if (!context.mounted) return;
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(error.toString())),
                              );
                            }
                          }
                        : null,
                    icon: const Icon(Icons.send_rounded),
                    label: const Text('Enviar'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _DocumentsSection extends StatelessWidget {
  const _DocumentsSection({required this.repository, required this.solicitud});

  final StudentApplicationRepository repository;
  final SolicitudMobilidadData solicitud;

  static const _requiredDocuments = {
    'carta_motivacion': 'Carta de motivacion',
    'documento_identidad': 'Documento de identidad',
  };

  @override
  Widget build(BuildContext context) {
    final canEdit = solicitud.estado == 'borrador' && !solicitud.bloqueada;

    return StreamBuilder<List<DocumentoData>>(
      stream: repository.watchDocuments(solicitud.id),
      builder: (context, snapshot) {
        final documents = snapshot.data ?? const <DocumentoData>[];
        final uploadedTypes = documents
            .map((item) => item.tipoDocumento)
            .toSet();
        final missing = _requiredDocuments.entries
            .where((entry) => !uploadedTypes.contains(entry.key))
            .map((entry) => entry.value)
            .toList();

        return DetailSection(
          title: 'Documentos requeridos',
          rows: [
            if (missing.isEmpty)
              const Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Text('Documentos completos para enviar.'),
              )
            else
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text('Pendientes: ${missing.join(', ')}.'),
              ),
            if (documents.isEmpty)
              const Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Text('Aun no hay documentos cargados.'),
              )
            else
              ...documents.map(
                (document) => _DocumentRow(
                  document: document,
                  label:
                      _requiredDocuments[document.tipoDocumento] ??
                      document.tipoDocumento,
                  canEdit: canEdit,
                  onDelete: () async {
                    try {
                      await repository.deleteDocument(document);
                      if (!context.mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Documento eliminado.')),
                      );
                    } catch (error) {
                      if (!context.mounted) return;
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(error.toString())));
                    }
                  },
                ),
              ),
            if (canEdit && missing.isNotEmpty)
              Align(
                alignment: Alignment.centerLeft,
                child: FilledButton.icon(
                  onPressed: () => _showDocumentDialog(context, documents),
                  icon: const Icon(Icons.upload_file_outlined),
                  label: const Text('Cargar documento'),
                ),
              ),
          ],
        );
      },
    );
  }

  Future<void> _showDocumentDialog(
    BuildContext context,
    List<DocumentoData> documents,
  ) async {
    var selectedType = _requiredDocuments.keys.firstWhere(
      (type) => !documents.any((document) => document.tipoDocumento == type),
      orElse: () => _requiredDocuments.keys.first,
    );
    String fileName = '';

    await showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Cargar documento'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropdownButtonFormField<String>(
                    initialValue: selectedType,
                    decoration: const InputDecoration(
                      labelText: 'Tipo de documento',
                    ),
                    items: _requiredDocuments.entries
                        .map(
                          (entry) => DropdownMenuItem(
                            value: entry.key,
                            child: Text(entry.value),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      if (value == null) return;
                      setState(() => selectedType = value);
                    },
                  ),
                  const SizedBox(height: 14),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Nombre del archivo',
                      hintText: 'Ej: carta_motivacion.pdf',
                    ),
                    onChanged: (value) => fileName = value,
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(dialogContext).pop(),
                  child: const Text('Cancelar'),
                ),
                FilledButton(
                  onPressed: () async {
                    final trimmed = fileName.trim();
                    if (trimmed.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Ingresa el nombre del archivo.'),
                        ),
                      );
                      return;
                    }
                    try {
                      await repository.addDocument(
                        solicitudId: solicitud.id,
                        tipoDocumento: selectedType,
                        nombreArchivo: trimmed,
                      );
                      if (!dialogContext.mounted) return;
                      Navigator.of(dialogContext).pop();
                      if (!context.mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Documento cargado.')),
                      );
                    } catch (error) {
                      if (!context.mounted) return;
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(error.toString())));
                    }
                  },
                  child: const Text('Guardar'),
                ),
              ],
            );
          },
        );
      },
    );

  }
}

class _DocumentRow extends StatelessWidget {
  const _DocumentRow({
    required this.document,
    required this.label,
    required this.canEdit,
    required this.onDelete,
  });

  final DocumentoData document;
  final String label;
  final bool canEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          const Icon(Icons.description_outlined),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                Text(document.nombreArchivo),
              ],
            ),
          ),
          StatusPill(status: document.estado),
          if (document.pendingSync) ...[
            const SizedBox(width: 8),
            const Icon(
              Icons.cloud_off_outlined,
              size: 18,
              color: Colors.orange,
            ),
          ],
          if (canEdit) ...[
            const SizedBox(width: 8),
            IconButton(
              tooltip: 'Eliminar documento',
              onPressed: onDelete,
              icon: const Icon(Icons.delete_outline),
            ),
          ],
        ],
      ),
    );
  }
}

class _StatusHeader extends StatelessWidget {
  const _StatusHeader({required this.solicitud});

  final SolicitudMobilidadData solicitud;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          children: [
            Icon(
              Icons.assignment_turned_in_outlined,
              color: statusColor(context, solicitud.estado),
              size: 32,
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    solicitud.programaAcademico.isEmpty
                        ? 'Solicitud en borrador'
                        : solicitud.programaAcademico,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    'Creada el ${formatStudentDate(solicitud.fechaCreacion)}',
                  ),
                  if (solicitud.pendingSync)
                    Text(
                      'Pendiente de sincronizar',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.orange.shade800,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                ],
              ),
            ),
            StatusPill(status: solicitud.estado),
          ],
        ),
      ),
    );
  }
}

class _HistorySection extends StatelessWidget {
  const _HistorySection({required this.repository, required this.solicitudId});

  final StudentApplicationRepository repository;
  final String solicitudId;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<HistorialEstadoData>>(
      stream: repository.watchHistory(solicitudId),
      builder: (context, snapshot) {
        final history = snapshot.data ?? const <HistorialEstadoData>[];
        return DetailSection(
          title: 'Historial',
          rows: history.isEmpty
              ? [const Text('Aun no hay cambios registrados.')]
              : history
                    .map(
                      (item) => Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Text(
                          '${statusLabel(item.estadoAnterior)} -> ${statusLabel(item.estadoNuevo)} · ${formatStudentDate(item.fechaCambio)}',
                        ),
                      ),
                    )
                    .toList(),
        );
      },
    );
  }
}
