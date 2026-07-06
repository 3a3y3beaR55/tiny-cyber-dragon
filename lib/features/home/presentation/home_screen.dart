import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router/app_router.dart';
import '../../../core/theme/theme.dart';
import '../../../shared/byte/byte.dart';
import '../../../shared/widgets/widgets.dart';
import '../../../dragon/dragon_animation.dart';

import '../../../dragon/byte_animation_frames.dart';
import '../../../dragon/byte_controller_provider.dart';

/// HomeScreen — Dashboard v0.1.
///
/// The user's daily starting point: Byte's status, one actionable tip, and
/// previews of Learn / Missions / Threats. All content is placeholder this
/// sprint; each preview section will read from its feature's providers once
/// real data exists — the layout won't change.
///
/// Design promise: everything here should make the user feel more confident
/// than they did five minutes ago.
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ByteState byte = ref.watch(byteStatusProvider);
    final ByteAnimationState animationState =
        ref.watch(byteControllerProvider).state;
    final ThemeData theme = Theme.of(context);

    return SingleChildScrollView(
      padding: Spacing.pagePadding,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 920),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: DragonAnimation(
                size: 180,
                frames: ByteAnimationFrames.frames[animationState]!,
              ),
            ),
            Spacing.gapMd,

            // ── Byte status ─────────────────────────────────────────────
            ByteStatusCard(
              state: byte,
              trailing: PrimaryButton(
                label: 'Run Safety Check',
                icon: Icons.radar,
                onPressed: () => _onScanPressed(context, ref),
              ),
            ),
            Spacing.gapMd,

            // ── TEMPORARY: Byte status test panel ───────────────────────
            // Visual test harness for the Byte Status System. Remove once
            // real features drive statuses. Tracked as tech debt on purpose.
            _ByteStatusTestPanel(
              current: byte.status,
              onSelect: (status) {
                ref.read(byteStatusProvider.notifier).setStatus(status);

                final controller = ref.read(byteControllerProvider);

                switch (status) {
                  case ByteStatus.idle:
                    controller.idle();
                    break;
                  case ByteStatus.scanning:
                    controller.scanning();
                    break;
                  case ByteStatus.warning:
                  case ByteStatus.threat:
                  case ByteStatus.critical:
                    controller.warning();
                    break;
                  case ByteStatus.complete:
                    controller.complete();
                    break;
                  case ByteStatus.learning:
                    controller.learning();
                    break;
                  case ByteStatus.updating:
                    controller.updating();
                    break;
                  case ByteStatus.sleeping:
                    controller.sleeping();
                    break;
                }
              },
            ),
            Spacing.gapMd,

            // ── Protection status + cyber tip ───────────────────────────
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Expanded(
                  child: StatusCard(
                    title: 'Learning Streak',
                    level: StatusLevel.safe,
                    badgeLabel: 'Day 1',
                    icon: Icons.local_fire_department_outlined,
                    description:
                        'Every lesson makes you harder to fool. Start today.',
                  ),
                ),
                Spacing.gapMd,
                Expanded(
                  child: StatusCard(
                    title: 'Cyber Tip of the Day',
                    level: StatusLevel.info,
                    icon: Icons.lightbulb_outline,
                    description:
                        'Turn on two-factor authentication for your email '
                        'first — it protects every account connected to it.',
                    onTap: () => ref.read(byteStatusProvider.notifier).say(
                          'Great tip, right? Your email is the key to '
                          'everything — guard it first!',
                        ),
                  ),
                ),
              ],
            ),
            Spacing.gapLg,

            // ── Continue learning ───────────────────────────────────────
            SectionHeader(
              title: 'Continue Learning',
              subtitle: 'Pick up where you left off',
              actionLabel: 'See all',
              onAction: () => context.go(AppRoutes.learn),
            ),
            LessonCard(
              title: 'Spotting Phishing Emails',
              description:
                  'Learn the five telltale signs of a scam email before '
                  'you ever click a link.',
              durationMinutes: 8,
              progress: 0.4,
              onTap: () => context.go(AppRoutes.learn),
            ),
            Spacing.gapLg,

            // ── Next mission ────────────────────────────────────────────
            SectionHeader(
              title: 'Next Mission',
              subtitle: 'Practice makes protected',
              actionLabel: 'See all',
              onAction: () => context.go(AppRoutes.missions),
            ),
            MissionCard(
              title: 'Password Fortress',
              description:
                  'Build an unbreakable password and learn what makes it '
                  'strong.',
              difficulty: MissionDifficulty.beginner,
              onTap: () => context.go(AppRoutes.missions),
            ),
            Spacing.gapLg,

            // ── Threat spotlight ────────────────────────────────────────
            SectionHeader(
              title: 'Threat Spotlight',
              subtitle: 'Know it to beat it',
              actionLabel: 'Threat Library',
              onAction: () => context.go(AppRoutes.threats),
            ),
            ThreatCard(
              title: 'Phishing',
              severity: StatusLevel.warning,
              categoryLabel: 'Email',
              summary:
                  'Fake messages that impersonate trusted senders to steal '
                  'passwords or money. The #1 threat for everyday users.',
              onTap: () => context.go(AppRoutes.threats),
            ),
            Spacing.gapXl,
            Center(
              child: Text(
                'Every feature should make you feel more confident than '
                'you did five minutes ago.',
                style: theme.textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Placeholder scan action — real defensive scanning ships in a future
  /// sprint. Byte reacts so the interaction still feels alive.
  Future<void> _onScanPressed(BuildContext context, WidgetRef ref) async {
    ref
        .read(byteStatusProvider.notifier)
        .setStatus(ByteStatus.scanning, message: 'Warming up my scanners…');
    await AppDialog.show(
      context,
      title: 'Safety Check — coming soon',
      body: 'In an upcoming update, Byte will walk you through a guided '
          'safety checkup of your accounts and habits. No scary scans — '
          'just clear, friendly steps.',
      level: StatusLevel.info,
      confirmLabel: 'Got it',
    );
    ref.read(byteStatusProvider.notifier).relax();
  }
}

/// TEMPORARY test harness: buttons that switch Byte between all statuses
/// so the Byte Status System can be verified visually. Not a product
/// feature — remove when real features drive statuses.
class _ByteStatusTestPanel extends StatelessWidget {
  const _ByteStatusTestPanel({required this.current, required this.onSelect});

  final ByteStatus current;
  final ValueChanged<ByteStatus> onSelect;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return AppCard(
      accentColor: StatusColors.neutral,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.science_outlined,
                size: 18,
                color: theme.colorScheme.onSurface,
              ),
              Spacing.gapXs,
              Text(
                'Byte Status Test Panel (temporary)',
                style: theme.textTheme.titleMedium,
              ),
            ],
          ),
          Spacing.gapXxs,
          Text(
            'Development harness — switches Byte between statuses to '
            'verify visuals. Remove before release.',
            style: theme.textTheme.bodyMedium,
          ),
          Spacing.gapSm,
          Wrap(
            spacing: Spacing.xs,
            runSpacing: Spacing.xs,
            children: [
              for (final ByteStatus status in ByteStatus.values)
                _StatusChip(
                  status: status,
                  selected: status == current,
                  onTap: () => onSelect(status),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({
    required this.status,
    required this.selected,
    required this.onTap,
  });

  final ByteStatus status;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Color accent = status.data.accentColor;

    return Material(
      color:
          selected ? accent.withValues(alpha: 0.18) : theme.colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Spacing.radiusFull),
        side: BorderSide(
          color: selected ? accent : theme.colorScheme.outline,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(Spacing.radiusFull),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Spacing.sm,
            vertical: Spacing.xxs,
          ),
          child: Text(
            status.name,
            style: theme.textTheme.labelSmall!.copyWith(
              color: selected ? accent : theme.colorScheme.onSurface,
            ),
          ),
        ),
      ),
    );
  }
}
