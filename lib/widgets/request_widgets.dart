part of '../main.dart';

class RequestSummaryCard extends StatelessWidget {
  const RequestSummaryCard({
    super.key,
    required this.application,
    this.onTap,
    this.subtitle,
  });

  final MobilityApplication application;
  final VoidCallback? onTap;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          application.studentName,
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          subtitle ??
                              '${application.destinationUniversity} · ${application.country}',
                          style: TextStyle(color: Colors.grey.shade700),
                        ),
                      ],
                    ),
                  ),
                  _StatusChip(status: application.status),
                ],
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  _MiniDataPill(
                    label: application.id,
                    icon: Icons.badge_outlined,
                  ),
                  _MiniDataPill(
                    label: formatDate(application.createdAt),
                    icon: Icons.event_outlined,
                  ),
                  _MiniDataPill(
                    label: application.exchangeSemester,
                    icon: Icons.school_outlined,
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

class _StatusHeader extends StatelessWidget {
  const _StatusHeader({required this.application});

  final MobilityApplication application;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    application.studentName,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                _StatusChip(status: application.status),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              'Destino: ${application.destinationUniversity}, ${application.country}',
            ),
            if (application.adminComment.isNotEmpty) ...[
              const SizedBox(height: 12),
              Text(
                'Comentario administrativo: ${application.adminComment}',
                style: TextStyle(color: Colors.grey.shade800),
              ),
            ],
            if (application.rejectionReason.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                'Motivo de rechazo: ${application.rejectionReason}',
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.status});

  final ApplicationStatus status;

  @override
  Widget build(BuildContext context) {
    final color = status.color(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        status.label,
        style: TextStyle(color: color, fontWeight: FontWeight.w700),
      ),
    );
  }
}

class _MiniDataPill extends StatelessWidget {
  const _MiniDataPill({required this.label, required this.icon});

  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F7FB),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [Icon(icon, size: 18), const SizedBox(width: 8), Text(label)],
      ),
    );
  }
}
