import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/widgets/async_body.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/section_card.dart';
import '../../progression/data/growth_service.dart';
import '../../progression/data/growth_state.dart';
import '../../progression/domain/evolution.dart';
import '../../progression/domain/scoring_rules.dart';
import '../domain/excuse.dart';
import '../domain/habit.dart';
import 'habit_form.dart';
import 'mission_tile.dart';

class MissionsScreen extends ConsumerWidget {
  const MissionsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Missions')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showHabitForm(context),
        icon: const Icon(Icons.add),
        label: const Text('Habit'),
      ),
      body: AsyncBody(
        value: ref.watch(growthStateProvider),
        data: (s) => ListView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 96),
          children: [
            for (final m in s.missions)
              if (m.advice != EvolutionAdvice.none) ...[
                _EvolutionCard(mission: m),
                const SizedBox(height: 12),
              ],
            SectionCard(
              title:
                  "Today's missions · ${s.missionsDone} of "
                  '${s.missions.length}',
              child: s.missions.isEmpty
                  ? const EmptyState(
                      'Nothing scheduled today. Add a habit to start earning XP.',
                    )
                  : Column(
                      children: [
                        for (final m in s.missions) MissionTile(mission: m),
                      ],
                    ),
            ),
            const SizedBox(height: 12),
            _ExcuseCard(state: s),
            const SizedBox(height: 12),
            SectionCard(
              title: 'All habits',
              child: s.habits.isEmpty
                  ? const EmptyState('No habits yet.')
                  : Column(
                      children: [
                        for (final h in s.habits) _HabitRow(habit: h, state: s),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HabitRow extends StatelessWidget {
  const _HabitRow({required this.habit, required this.state});

  final Habit habit;
  final GrowthState state;

  @override
  Widget build(BuildContext context) {
    final days = habit.isDaily
        ? 'Every day'
        : [for (final d in habit.weekdays.toList()..sort()) _dayNames[d - 1]]
              .join(', ');
    final streak = state.history.streak(habit, state.today);
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(habit.name),
      subtitle: Text(
        [
          days,
          '${habit.baseXp} base XP',
          if (habit.area != null) habit.area!,
          if (streak > 0) '🔥 $streak',
        ].join(' · '),
      ),
      trailing: const Icon(Icons.edit_outlined),
      onTap: () => showHabitForm(context, habit: habit),
    );
  }
}

const _dayNames = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

class _EvolutionCard extends ConsumerWidget {
  const _EvolutionCard({required this.mission});

  final MissionView mission;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final h = mission.habit;
    final service = ref.read(growthServiceProvider);
    final stepBack = mission.advice == EvolutionAdvice.offerStepBack;
    final next = h.target == null
        ? null
        : (h.target! * ScoringRules.evolveTargetFactor).ceil();
    final unit = h.unit ?? '';

    return Card(
      color: theme.colorScheme.primaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              stepBack ? 'RECOVERY OPTION' : 'EVOLUTION OPPORTUNITY',
              style: theme.textTheme.labelMedium,
            ),
            const SizedBox(height: 4),
            Text(
              stepBack
                  ? 'The new "${h.name}" target is a stretch right now.'
                  : 'You\'ve built a strong "${h.name}" routine.',
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: 4),
            Text(
              stepBack
                  ? 'Step back to ${h.previousTarget} $unit with no penalty. '
                        'An unsuccessful attempt is useful feedback.'
                  : 'Would you like to increase the difficulty?',
            ),
            const SizedBox(height: 12),
            if (stepBack)
              Row(
                children: [
                  TextButton(
                    onPressed: () => service.declineEvolve(h),
                    child: const Text('Keep going'),
                  ),
                  const Spacer(),
                  FilledButton(
                    onPressed: () => service.stepBack(h),
                    child: Text('Step back to ${h.previousTarget}'),
                  ),
                ],
              )
            else
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => service.declineEvolve(h),
                      child: Text(
                        'Stay · ${h.target} $unit\n${h.baseXp} XP',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FilledButton(
                      onPressed: () => service.acceptEvolve(h),
                      child: Text(
                        'Evolve · $next $unit\n'
                        '${(h.baseXp + 1).clamp(1, 5)} XP',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class _ExcuseCard extends ConsumerWidget {
  const _ExcuseCard({required this.state});

  final GrowthState state;

  Future<void> _excuse(BuildContext context, WidgetRef ref) async {
    var reason = ExcuseReason.sick;
    final note = TextEditingController();
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Excuse today'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                state.excusesLeft > 0
                    ? 'No XP or Momentum loss, and streaks pause instead of '
                          'breaking. ${state.excusesLeft} of '
                          '${ScoringRules.excusesPerMonth} left this month.'
                    : 'You\'ve used this month\'s '
                          '${ScoringRules.excusesPerMonth} penalty-free '
                          'excuses. Streaks will still pause, but missed '
                          'missions are penalized.',
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 6,
                children: [
                  for (final r in ExcuseReason.values)
                    ChoiceChip(
                      label: Text(
                        r.name[0].toUpperCase() + r.name.substring(1),
                      ),
                      selected: reason == r,
                      onSelected: (_) => setState(() => reason = r),
                    ),
                ],
              ),
              TextField(
                controller: note,
                decoration: const InputDecoration(labelText: 'Note (optional)'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Excuse today'),
            ),
          ],
        ),
      ),
    );
    if (ok == true) {
      await ref
          .read(growthServiceProvider)
          .excuseToday(reason, note.text.trim().isEmpty ? null : note.text);
    }
    note.dispose();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      color: Theme.of(context).colorScheme.surfaceContainerLow,
      child: ListTile(
        leading: const Icon(Icons.healing_outlined),
        title: Text(state.excusedToday ? 'Today is excused' : 'Rough day?'),
        subtitle: Text(
          state.excusedToday
              ? 'Streaks are paused for today. Tap to undo.'
              : 'Sick, travelling or an emergency: excuse today. '
                    '${state.excusesLeft} left this month.',
        ),
        onTap: state.excusedToday
            ? () => ref.read(growthServiceProvider).clearExcuse(state.today)
            : () => _excuse(context, ref),
      ),
    );
  }
}
