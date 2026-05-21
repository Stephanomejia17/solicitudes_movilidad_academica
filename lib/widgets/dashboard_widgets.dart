part of '../main.dart';

class _WelcomeBanner extends StatelessWidget {
  const _WelcomeBanner({required this.user, required this.onCreateRequest});

  final AppUser user;
  final VoidCallback onCreateRequest;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: LinearGradient(
          colors: [theme.colorScheme.primary, theme.colorScheme.secondary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hola, ${user.firstName}',
            style: theme.textTheme.headlineSmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Prepara tu proxima experiencia academica internacional con un flujo claro y ordenado.',
            style: TextStyle(color: Colors.white, height: 1.5),
          ),
          const SizedBox(height: 20),
          FilledButton.tonalIcon(
            style: FilledButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: theme.colorScheme.primary,
            ),
            onPressed: onCreateRequest,
            icon: const Icon(Icons.flight_takeoff_rounded),
            label: const Text('Crear nueva solicitud'),
          ),
        ],
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({
    required this.title,
    required this.value,
    required this.icon,
  });

  final String title;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 240,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Theme.of(
                    context,
                  ).colorScheme.primary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon),
              ),
              const SizedBox(height: 16),
              Text(
                value,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 4),
              Text(title),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatusChart extends StatelessWidget {
  const _StatusChart({required this.values});

  final Map<String, int> values;

  @override
  Widget build(BuildContext context) {
    final maxValue = values.values.fold<int>(
      1,
      (max, value) => value > max ? value : max,
    );
    final colors = [
      Colors.orange.shade400,
      Colors.green.shade400,
      Colors.red.shade400,
    ];

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: values.entries.toList().asMap().entries.map((entry) {
        final index = entry.key;
        final item = entry.value;
        final height = (item.value / maxValue) * 180;
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  '${item.value}',
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 10),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  height: height.clamp(28, 180),
                  decoration: BoxDecoration(
                    color: colors[index],
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                const SizedBox(height: 10),
                Text(item.key, textAlign: TextAlign.center),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
