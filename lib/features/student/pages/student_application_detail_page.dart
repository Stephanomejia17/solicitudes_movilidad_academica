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
                              MaterialPageRoute<void>(
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
                    solicitud.programaAcademico,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    'Creada el ${formatStudentDate(solicitud.fechaCreacion)}',
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
