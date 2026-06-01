import 'package:flutter/material.dart';

import '../../../data/app_database.dart';

String formatStudentDate(DateTime? value) {
  if (value == null) return 'Sin fecha';
  final day = value.day.toString().padLeft(2, '0');
  final month = value.month.toString().padLeft(2, '0');
  return '$day/$month/${value.year}';
}

String statusLabel(String status) {
  return switch (status) {
    'borrador' => 'Borrador',
    'enviada' => 'Enviada',
    'en_revision' => 'En revision',
    'aprobada' => 'Aprobada',
    'rechazada' => 'Rechazada',
    'cancelada' => 'Cancelada',
    _ => status,
  };
}

Color statusColor(BuildContext context, String status) {
  final colors = Theme.of(context).colorScheme;
  return switch (status) {
    'aprobada' => Colors.green.shade700,
    'rechazada' || 'cancelada' => colors.error,
    'enviada' || 'en_revision' => Colors.indigo.shade700,
    _ => colors.primary,
  };
}

class WelcomeBanner extends StatelessWidget {
  const WelcomeBanner({
    super.key,
    required this.user,
    required this.onCreateRequest,
  });

  final UsuarioData user;
  final VoidCallback onCreateRequest;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colors.primary,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hola, ${user.nombre}',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: colors.onPrimary,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Gestiona tus solicitudes de movilidad academica y revisa el avance de cada proceso.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: colors.onPrimary.withValues(alpha: 0.9),
            ),
          ),
          const SizedBox(height: 16),
          FilledButton.tonalIcon(
            onPressed: onCreateRequest,
            icon: const Icon(Icons.add_rounded),
            label: const Text('Nueva solicitud'),
          ),
        ],
      ),
    );
  }
}

class StatCard extends StatelessWidget {
  const StatCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });

  final String title;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return SizedBox(
      width: 168,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: colors.primary),
              const SizedBox(height: 14),
              Text(
                value,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 4),
              Text(title, style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
        ),
      ),
    );
  }
}

class EmptyState extends StatelessWidget {
  const EmptyState({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    this.actionLabel,
    this.onAction,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Icon(icon, size: 42, color: colors.primary),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            if (actionLabel != null && onAction != null) ...[
              const SizedBox(height: 16),
              FilledButton(onPressed: onAction, child: Text(actionLabel!)),
            ],
          ],
        ),
      ),
    );
  }
}

class RequestSummaryCard extends StatelessWidget {
  const RequestSummaryCard({super.key, required this.solicitud, this.onTap});

  final SolicitudMobilidadData solicitud;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final color = statusColor(context, solicitud.estado);

    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      solicitud.universidadDestinoNombre.isEmpty
                          ? solicitud.programaAcademico
                          : solicitud.universidadDestinoNombre,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  StatusPill(status: solicitud.estado),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                '${solicitud.programaAcademico} - ${solicitud.tipoMovilidad}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 12,
                runSpacing: 8,
                children: [
                  _Meta(
                    icon: Icons.calendar_today,
                    text: formatStudentDate(solicitud.fechaCreacion),
                  ),
                  _Meta(
                    icon: Icons.school_outlined,
                    text: 'Semestre ${solicitud.semestre}',
                  ),
                  if (solicitud.pendingSync)
                    _Meta(
                      icon: Icons.cloud_off_outlined,
                      text: 'Pendiente de sincronizar',
                      color: color,
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StatusPill extends StatelessWidget {
  const StatusPill({super.key, required this.status});

  final String status;

  @override
  Widget build(BuildContext context) {
    final color = statusColor(context, status);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        statusLabel(status),
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
          color: color,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class DetailSection extends StatelessWidget {
  const DetailSection({super.key, required this.title, required this.rows});

  final String title;
  final List<Widget> rows;

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
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 12),
            ...rows,
          ],
        ),
      ),
    );
  }
}

Widget detailRow(String label, String value) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 138,
          child: Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w700),
          ),
        ),
        Expanded(child: Text(value.isEmpty ? 'No registrado' : value)),
      ],
    ),
  );
}

class _Meta extends StatelessWidget {
  const _Meta({required this.icon, required this.text, this.color});

  final IconData icon;
  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final effectiveColor =
        color ?? Theme.of(context).colorScheme.onSurfaceVariant;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: effectiveColor),
        const SizedBox(width: 6),
        Text(
          text,
          style: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(color: effectiveColor),
        ),
      ],
    );
  }
}
