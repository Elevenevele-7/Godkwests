import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../progression/data/growth_service.dart';
import '../../progression/data/growth_state.dart';
import 'habit_form.dart';

/// One of today's missions: tick to complete, shows XP and streak.
class MissionTile extends ConsumerWidget {
  const MissionTile({super.key, required this.mission, this.dense = false});

  final MissionView mission;
  final bool dense;

  Future<void> _toggle(BuildContext context, WidgetRef ref) async {
    final service = ref.read(growthServiceProvider);
    if (mission.done) {
      await service.undoMission(mission.habit);
      return;
    }
    final xp = await service.completeMission(mission.habit);
    if (xp != null && context.mounted) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text('+${xp.xp} XP · ${xp.explanation}'),
            duration: const Duration(seconds: 2),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final h = mission.habit;
    final subtitle = [
      if (mission.streak > 0) '🔥 ${mission.streak}',
      if (h.target != null) '${h.target} ${h.unit ?? ''}'.trim(),
      if (mission.inRecovery) 'Recovery challenge',
    ].join(' · ');
    return ListTile(
      dense: dense,
      contentPadding: dense ? EdgeInsets.zero : null,
      leading: Checkbox(
        value: mission.done,
        onChanged: (_) => _toggle(context, ref),
      ),
      title: Text(
        h.name,
        style: mission.done
            ? TextStyle(
                decoration: TextDecoration.lineThrough,
                color: theme.colorScheme.onSurfaceVariant,
              )
            : null,
      ),
      subtitle: subtitle.isEmpty ? null : Text(subtitle),
      trailing: Text(
        '+${mission.xp} XP',
        style: theme.textTheme.labelLarge?.copyWith(
          color: mission.done
              ? theme.colorScheme.primary
              : theme.colorScheme.onSurfaceVariant,
        ),
      ),
      onTap: () => _toggle(context, ref),
      onLongPress: () => showHabitForm(context, habit: h),
    );
  }
}
