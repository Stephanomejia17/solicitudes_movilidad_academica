import 'package:flutter/material.dart';

import '../../../data/app_database.dart';
import '../services/coordinator_repository.dart';

class CoordinatorSolicitudDetailPage extends StatefulWidget {
  const CoordinatorSolicitudDetailPage({super.key, required this.solicitudId});

  final String solicitudId;

  @override
  State<CoordinatorSolicitudDetailPage> createState() =>
      _CoordinatorSolicitudDetailPageState();
}

class _CoordinatorSolicitudDetailPageState
    extends State<CoordinatorSolicitudDetailPage> {
  @override
  Widget build(BuildContext context) {
    final db = AppStateScope.of(context);
    final repository = CoordinatorRepository(database: db);
    final coordinator = db.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle de solicitud'),
      ),
      body: StreamBuilder<SolicitudMobilidadData?>(
        stream: repository.watchSolicitud(widget.solicitudId),
        builder: (context, solicitudSnapshot) {
          if (!solicitudSnapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final solicitud = solicitudSnapshot.data;
          if (solicitud == null) {
            return const Center(
              child: Text('La solicitud no esta disponible en la base local.'),
            );
          }

          return StreamBuilder<List<AprobacionData>>(
            stream: repository.watchAprobaciones(widget.solicitudId),
            builder: (context, aprobacionesSnapshot) {
              final aprobaciones = aprobacionesSnapshot.data ?? const [];

              return ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  _HeaderCard(solicitud: solicitud),
                  const SizedBox(height: 16),
                  _SectionCard(
                    title: 'Informacion general',
                    children: [
                      _DetailRow(
                        label: 'Estudiante',
                        value: '${solicitud.nombres} ${solicitud.apellidos}',
                      ),
                      _DetailRow(
                        label: 'Documento',
                        value:
                            '${solicitud.tipoDocumento} ${solicitud.numeroDocumento}',
                      ),
                      _DetailRow(
                        label: 'Tipo movilidad',
                        value: solicitud.tipoMovilidad,
                      ),
                      _DetailRow(
                        label: 'Universidad destino',
                        value: solicitud.universidadDestinoNombre,
                      ),
                      _DetailRow(
                        label: 'Programa academico',
                        value: solicitud.programaAcademico,
                      ),
                      _DetailRow(
                        label: 'Semestre',
                        value: '${solicitud.semestre}',
                      ),
                      _DetailRow(
                        label: 'Promedio',
                        value: '${solicitud.promedioAcumulado}',
                      ),
                      _DetailRow(
                        label: 'Fecha de viaje',
                        value: _formatDate(solicitud.fechaViaje),
                      ),
                      _DetailRow(
                        label: 'Fecha de regreso',
                        value: _formatDate(solicitud.fechaRegreso),
                      ),
                      _DetailRow(
                        label: 'Estado',
                        value: solicitud.estado,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _SectionCard(
                    title: 'Contacto y estudios',
                    children: [
                      _DetailRow(
                        label: 'Email institucional',
                        value: solicitud.emailInstitucional,
                      ),
                      _DetailRow(
                        label: 'Email personal',
                        value: solicitud.emailPersonal,
                      ),
                      _DetailRow(
                        label: 'Telefono',
                        value: solicitud.telefono,
                      ),
                      _DetailRow(
                        label: 'Contacto emergencia',
                        value: solicitud.contactoEmergencia,
                      ),
                      _DetailRow(
                        label: 'Relacion contacto',
                        value: solicitud.relacionContacto,
                      ),
                      _DetailRow(
                        label: 'Facultad actual',
                        value: solicitud.facultad,
                      ),
                      _DetailRow(
                        label: 'Area de estudio',
                        value: solicitud.areaEstudio,
                      ),
                      _DetailRow(
                        label: 'Nivel de idioma',
                        value: solicitud.nivelIdioma,
                      ),
                      _DetailRow(
                        label: 'Puntaje idioma',
                        value: solicitud.puntajeIdioma,
                      ),
                      _DetailRow(
                        label: 'Semestre intercambio',
                        value: solicitud.semestreIntercambio,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _SectionCard(
                    title: 'Acciones de revision',
                    children: [
                      if (solicitud.estado == 'enviada')
                        Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          children: [
                            FilledButton.icon(
                              onPressed: coordinator == null
                                  ? null
                                  : () => _review(
                                        context,
                                        repository,
                                        coordinator,
                                        solicitud.id,
                                        approve: true,
                                      ),
                              icon: const Icon(Icons.check),
                              label: const Text('Aprobar'),
                            ),
                            FilledButton.tonalIcon(
                              onPressed: coordinator == null
                                  ? null
                                  : () => _review(
                                        context,
                                        repository,
                                        coordinator,
                                        solicitud.id,
                                        approve: false,
                                      ),
                              icon: const Icon(Icons.close),
                              label: const Text('Rechazar'),
                            ),
                          ],
                        )
                      else
                        Text(
                          'Solo las solicitudes enviadas pueden revisarse.',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _SectionCard(
                    title: 'Aprobaciones registradas',
                    children: [
                      if (aprobaciones.isEmpty)
                        const Text('Aun no hay aprobaciones o rechazos.'),
                      for (final item in aprobaciones)
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: Icon(
                            item.decision == 'aprobada'
                                ? Icons.check_circle_outline
                                : Icons.cancel_outlined,
                          ),
                          title: Text(
                            '${item.decision.toUpperCase()} | ${item.comentario}',
                          ),
                          subtitle: Text(
                            'Fecha: ${_formatDate(item.fechaDecision)}',
                          ),
                        ),
                    ],
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  Future<void> _review(
    BuildContext context,
    CoordinatorRepository repository,
    UsuarioData coordinator,
    String solicitudId, {
    required bool approve,
  }) async {
    final result = await showDialog<String>(
      context: context,
      builder: (_) {
        return _ReviewDialog(approve: approve);
      },
    );

    if (result == null) return;

    try {
      if (approve) {
        await repository.approve(
          actor: coordinator,
          solicitudId: solicitudId,
          comentario: result,
        );
      } else {
        await repository.reject(
          actor: coordinator,
          solicitudId: solicitudId,
          motivo: result,
        );
      }
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            approve ? 'Solicitud aprobada.' : 'Solicitud rechazada.',
          ),
        ),
      );
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$error')),
      );
    }
  }

  String _formatDate(DateTime? value) {
    if (value == null) return 'N/D';
    final day = value.day.toString().padLeft(2, '0');
    final month = value.month.toString().padLeft(2, '0');
    final hour = value.hour.toString().padLeft(2, '0');
    final minute = value.minute.toString().padLeft(2, '0');
    return '$day/$month/${value.year} $hour:$minute';
  }
}

class _HeaderCard extends StatelessWidget {
  const _HeaderCard({required this.solicitud});

  final SolicitudMobilidadData solicitud;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.description_outlined, size: 36),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    solicitud.programaAcademico,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                  const SizedBox(height: 6),
                  Text('${solicitud.nombres} ${solicitud.apellidos}'),
                  Text('Estado: ${solicitud.estado}'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.title,
    required this.children,
  });

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
            ),
            const SizedBox(height: 12),
            ...children,
          ],
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(child: Text(value.isEmpty ? 'N/D' : value)),
        ],
      ),
    );
  }
}

class _ReviewDialog extends StatefulWidget {
  const _ReviewDialog({required this.approve});

  final bool approve;

  @override
  State<_ReviewDialog> createState() => _ReviewDialogState();
}

class _ReviewDialogState extends State<_ReviewDialog> {
  final _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.approve ? 'Aprobar solicitud' : 'Rechazar solicitud'),
      content: Form(
        key: _formKey,
        child: TextFormField(
          controller: _controller,
          minLines: 3,
          maxLines: 5,
          decoration: InputDecoration(
            labelText: widget.approve ? 'Comentario opcional' : 'Motivo obligatorio',
          ),
          validator: (value) {
            if (!widget.approve && (value == null || value.trim().isEmpty)) {
              return 'Debes registrar un motivo.';
            }
            return null;
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancelar'),
        ),
        FilledButton(
          onPressed: () {
            if (!_formKey.currentState!.validate()) return;
            Navigator.of(context).pop(_controller.text.trim());
          },
          child: Text(widget.approve ? 'Aprobar' : 'Rechazar'),
        ),
      ],
    );
  }
}
