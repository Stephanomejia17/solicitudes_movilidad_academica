part of '../main.dart';

class _AuthHero extends StatelessWidget {
  const _AuthHero({this.compact = false});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.all(compact ? 24 : 36),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        gradient: LinearGradient(
          colors: [theme.colorScheme.primary, const Color(0xFF155E75)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(999),
            ),
            child: const Text(
              'Movilidad academica UdeM',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 28),
          Text(
            'Gestiona tus intercambios desde un solo lugar.',
            style: theme.textTheme.headlineMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Registro, autenticacion, seguimiento de solicitudes y revision administrativa con una experiencia mobile-first.',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: Colors.white.withValues(alpha: 0.88),
              height: 1.5,
            ),
          ),
          const SizedBox(height: 28),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: const [
              _HeroChip(label: 'Material 3'),
              _HeroChip(label: 'Flujo por roles'),
              _HeroChip(label: 'CRUD completo'),
              _HeroChip(label: 'Estados y revision'),
            ],
          ),
        ],
      ),
    );
  }
}

class _HeroChip extends StatelessWidget {
  const _HeroChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _AuthPanel extends StatelessWidget {
  const _AuthPanel({required this.showLogin, required this.onToggle});

  final bool showLogin;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SegmentedButton<bool>(
              segments: const [
                ButtonSegment<bool>(value: true, label: Text('Login')),
                ButtonSegment<bool>(value: false, label: Text('Registro')),
              ],
              selected: {showLogin},
              onSelectionChanged: (_) => onToggle(),
            ),
            const SizedBox(height: 24),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              child: showLogin
                  ? const LoginPage(key: ValueKey('login'))
                  : RegisterPage(
                      key: const ValueKey('register'),
                      onRegistered: onToggle,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
