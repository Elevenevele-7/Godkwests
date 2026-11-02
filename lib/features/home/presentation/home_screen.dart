import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router.dart';
import '../../../core/clock.dart';
import '../../../core/widgets/async_body.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/format.dart';
import '../../../core/widgets/section_card.dart';
import '../../../core/widgets/stat_tile.dart';
import '../../council/domain/insight.dart';
import '../../finance/data/finance_state.dart';
import '../../finance/domain/finance.dart';
import '../../knowledge/data/book_repository.dart';
import '../../missions/presentation/mission_tile.dart';
import '../../progression/data/growth_state.dart';
import '../../progression/domain/evolution.dart';
import '../../visions/data/vision_repository.dart';
import '../../visions/presentation/visions_screen.dart';

/// The Command Center. Order follows blueprint §8: finance first, then
/// missions and identity, then visions, learning and the Council.
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: AsyncBody(
          value: ref.watch(growthStateProvider),
          data: (s) => ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _Header(state: s),
              const SizedBox(height: 16),
              const _FinanceSnapshot(),
              const SizedBox(height: 12),
              _TodaysMissions(state: s),
              const SizedBox(height: 12),
              _Identity(state: s),
              const SizedBox(height: 12),
              const _ActiveVisions(),
              const SizedBox(height: 12),
              const _ContinueLearning(),
              const SizedBox(height: 12),
              _CouncilInsight(state: s),
            ],
          ),
        ),
      ),
    );
  }
}

class _Header extends ConsumerWidget {
  const _Header({required this.state});

  final GrowthState state;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final now = ref.watch(clockProvider)();
    final name = state.profile.displayName;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('YOUR PERSONAL GROWTH SYSTEM', style: theme.textTheme.labelMedium),
        const SizedBox(height: 4),
        Text(
          '${greeting(now)}${name.isEmpty ? '' : ', $name'}',
          style: theme.textTheme.headlineMedium,
        ),
        Text(
          "Your future is shaped by today's decisions.",
          style: theme.textTheme.bodyMedium,
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            Chip(
              avatar: const Icon(Icons.military_tech_outlined, size: 18),
              label: Text('Level ${state.level.level}'),
            ),
            if (state.bestStreak > 0)
              Chip(
                avatar: const Text('🔥'),
                label: Text('${state.bestStreak}-day streak'),
              ),
            Chip(label: Text('Momentum ${state.momentum}')),
          ],
        ),
        const SizedBox(height: 8),
        LinearProgressIndicator(value: state.level.fraction, minHeight: 6),
        const SizedBox(height: 4),
        Text(
          '${state.level.xpIntoLevel} / ${state.level.xpForNextLevel} XP to '
          'level ${state.level.level + 1}',
          style: theme.textTheme.bodySmall,
        ),
      ],
    );
  }
}

class _FinanceSnapshot extends ConsumerWidget {
  const _FinanceSnapshot();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final finance = ref.watch(financeStateProvider).value;
    return SectionCard(
      title: 'Financial Snapshot',
      onViewAll: () => context.go(Routes.finance),
      child: finance == null
          ? const EmptyState(
              'Set up your budget to see your daily allowance, fun budget '
              'and savings.',
            )
          : Builder(
              builder: (context) {
                final s = finance.snapshot;
                final cur = finance.settings.currency;
                final theme = Theme.of(context);
                return Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: StatTile(
                            label: 'Daily allowance',
                            value: money(s.dailyAllowance, cur),
                            emphasis: true,
                          ),
                        ),
                        Expanded(
                          child: StatTile(
                            label: 'Fun budget',
                            value: money(s.funToday, cur),
                            emphasis: true,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: StatTile(
                            label: 'Savings progress',
                            value: money(finance.savedTotal, cur),
                          ),
                        ),
                        Expanded(
                          child: StatTile(
                            label: 'Budget status',
                            value: s.status.label,
                          ),
                        ),
                      ],
                    ),
                    if (s.status == BudgetStatus.overBudget)
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                          'Over this week\'s budget. Review spending in '
                          'Finance.',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.error,
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
    );
  }
}

class _TodaysMissions extends StatelessWidget {
  const _TodaysMissions({required this.state});

  final GrowthState state;

  @override
  Widget build(BuildContext context) => SectionCard(
    title:
        "Today's Missions · ${state.missionsDone} of "
        '${state.missions.length}',
    onViewAll: () => context.go(Routes.missions),
    child: state.missions.isEmpty
        ? const EmptyState('No missions today. Add habits in Missions.')
        : Column(
            children: [
              for (final m in state.missions.take(5))
                MissionTile(mission: m, dense: true),
              if (state.missions.length > 5)
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('+${state.missions.length - 5} more'),
                ),
            ],
          ),
  );
}

class _Identity extends StatelessWidget {
  const _Identity({required this.state});

  final GrowthState state;

  @override
  Widget build(BuildContext context) => SectionCard(
    title: "Who You're Becoming",
    child: state.identity.isEmpty
        ? const EmptyState(
            'Choose the areas you want to grow in (Profile) to track your '
            'identity progress.',
          )
        : Column(
            children: [
              for (final e in state.identity.entries)
                ProgressRow(
                  label: e.key,
                  value: e.value == null ? null : e.value! / 100,
                ),
              if (state.lifeScore != null)
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    'Life Score ${state.lifeScore} · '
                    'Discipline ${state.discipline}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
            ],
          ),
  );
}

class _ActiveVisions extends ConsumerWidget {
  const _ActiveVisions();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final active = (ref.watch(visionsProvider).value ?? [])
        .where((v) => !v.isCompleted)
        .toList();
    return SectionCard(
      title: 'Active Visions',
      onViewAll: () => context.push(Routes.visions),
      child: active.isEmpty
          ? const EmptyState(
              'Define your first vision to connect it to your habits and '
              'budget.',
            )
          : Column(
              children: [for (final v in active.take(3)) VisionTile(vision: v)],
            ),
    );
  }
}

class _ContinueLearning extends ConsumerWidget {
  const _ContinueLearning();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final book = ref.watch(currentBookProvider).value;
    return SectionCard(
      title: 'Continue Learning',
      onViewAll: () => context.go(Routes.knowledge),
      child: book == null
          ? const EmptyState('Import a book or start a learning path.')
          : ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.menu_book_outlined),
              title: Text(book.title),
              subtitle: Text('${(book.progress * 100).round()}% read'),
              trailing: const Icon(Icons.play_arrow),
              onTap: () => context.push(Routes.reader(book.id)),
            ),
    );
  }
}

class _CouncilInsight extends ConsumerWidget {
  const _CouncilInsight({required this.state});

  final GrowthState state;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final advisor = state.profile.advisor;
    final finance = ref.watch(financeStateProvider).value;
    final recovering = state.missions.where((m) => m.inRecovery).firstOrNull;
    final evolve = state.missions
        .where((m) => m.advice == EvolutionAdvice.offerEvolve)
        .firstOrNull;
    final message = dailyInsight(
      advisor,
      InsightFacts(
        momentum: state.momentum,
        missionsLeft: state.missions.length - state.missionsDone,
        missionsTotal: state.missions.length,
        bestStreak: state.bestStreak,
        budgetOver: finance?.snapshot.status == BudgetStatus.overBudget,
        recoveringHabit: recovering?.habit.name,
        evolveHabit: evolve?.habit.name,
      ),
    );
    return SectionCard(
      title: "Today's Council Insight",
      onViewAll: () => context.push(Routes.council),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('"$message"', style: theme.textTheme.titleMedium),
          const SizedBox(height: 8),
          Text(advisor.title, style: theme.textTheme.labelMedium),
        ],
      ),
    );
  }
}
