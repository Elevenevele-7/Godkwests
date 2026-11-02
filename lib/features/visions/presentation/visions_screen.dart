import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/clock.dart';
import '../../../core/time/day.dart';
import '../../../core/widgets/async_body.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/format.dart';
import '../../../core/widgets/section_card.dart';
import '../../../core/widgets/stat_tile.dart';
import '../../missions/data/habit_repository.dart';
import '../../progression/data/growth_service.dart';
import '../../progression/data/reward_repository.dart';
import '../../progression/domain/reward.dart';
import '../data/vision_repository.dart';
import '../domain/vision.dart';
import '../domain/vision_points.dart';
import 'vision_form.dart';

class VisionsScreen extends ConsumerWidget {
  const VisionsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Visions')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showVisionForm(context),
        icon: const Icon(Icons.add),
        label: const Text('Vision'),
      ),
      body: AsyncBody(
        value: ref.watch(visionsProvider),
        data: (visions) {
          final active = visions.where((v) => !v.isCompleted).toList();
          final done = visions.where((v) => v.isCompleted).toList()
            ..sort((a, b) => b.completedOn!.compareTo(a.completedOn!));
          return ListView(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 96),
            children: [
              SectionCard(
                title: 'Active visions',
                child: active.isEmpty
                    ? const EmptyState(
                        'Define who you want to become: a goal, why it '
                        'matters, a deadline and milestones.',
                      )
                    : Column(
                        children: [
                          for (final v in active) VisionTile(vision: v),
                        ],
                      ),
              ),
              const SizedBox(height: 12),
              SectionCard(
                title: 'Completed: your permanent record',
                child: done.isEmpty
                    ? const EmptyState(
                        'Completed visions and their VP stay here forever.',
                      )
                    : Column(
                        children: [for (final v in done) VisionTile(vision: v)],
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class VisionTile extends StatelessWidget {
  const VisionTile({super.key, required this.vision});

  final Vision vision;

  @override
  Widget build(BuildContext context) {
    final v = vision;
    final detail = v.isCompleted
        ? 'Completed ${longDate(v.completedOn!)}'
        : v.targetValue != null
        ? '${number(v.currentValue)} of ${number(v.targetValue!)} '
              '${v.unit ?? ''} · due ${shortDate(v.deadline)}'
        : '${v.milestones.where((m) => m.isDone).length} of '
              '${v.milestones.length} milestones · due ${shortDate(v.deadline)}';
    return InkWell(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => VisionDetailScreen(visionId: v.id)),
      ),
      child: ProgressRow(label: '${v.title}\n$detail', value: v.progress),
    );
  }
}

class VisionDetailScreen extends ConsumerWidget {
  const VisionDetailScreen({super.key, required this.visionId});

  final String visionId;

  Future<void> _updateProgress(
    BuildContext context,
    WidgetRef ref,
    Vision v,
  ) async {
    final controller = TextEditingController(
      text: v.currentValue.toStringAsFixed(0),
    );
    final value = await showDialog<double>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Update progress'),
        content: TextField(
          controller: controller,
          autofocus: true,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: 'Current value',
            suffixText: v.unit,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () =>
                Navigator.pop(context, double.tryParse(controller.text)),
            child: const Text('Save'),
          ),
        ],
      ),
    );
    controller.dispose();
    if (value != null) {
      await ref
          .read(visionRepositoryProvider)
          .save(v.copyWith(currentValue: value));
    }
  }

  Future<void> _complete(BuildContext context, WidgetRef ref, Vision v) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Complete this vision?'),
        content: const Text(
          'It moves to your permanent record with its VP. This can\'t be '
          'undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Not yet'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Complete'),
          ),
        ],
      ),
    );
    if (ok == true) await ref.read(growthServiceProvider).completeVision(v);
  }

  Future<void> _delete(BuildContext context, WidgetRef ref, Vision v) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete this vision?'),
        content: const Text(
          'If the plan no longer fits, it\'s fine to let it go or revise '
          'it. Milestone VP already earned is kept.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (ok == true) {
      await ref.read(visionRepositoryProvider).delete(v);
      if (context.mounted) Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final visions = ref.watch(visionsProvider).value ?? [];
    final v = visions.where((v) => v.id == visionId).firstOrNull;
    if (v == null) return const Scaffold(body: SizedBox.shrink());

    final today = ref.watch(clockProvider)().dateOnly;
    final habits = (ref.watch(habitsProvider).value ?? [])
        .where((h) => h.visionId == v.id && h.archivedOn == null)
        .toList();
    final vpEarned = (ref.watch(rewardsProvider).value ?? [])
        .where((r) => r.currency == Currency.vp && r.refId == v.id)
        .fold(0, (s, r) => s + r.amount);
    final daysLeft = today.daysUntil(v.deadline);

    return Scaffold(
      appBar: AppBar(
        title: Text(v.isCompleted ? 'Completed vision' : 'Active vision'),
        actions: [
          if (!v.isCompleted) ...[
            IconButton(
              tooltip: 'Edit',
              icon: const Icon(Icons.edit_outlined),
              onPressed: () => showVisionForm(context, vision: v),
            ),
            IconButton(
              tooltip: 'Delete',
              icon: const Icon(Icons.delete_outline),
              onPressed: () => _delete(context, ref, v),
            ),
          ],
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(v.title, style: theme.textTheme.headlineSmall),
          if (v.why != null) ...[
            const SizedBox(height: 4),
            Text('"${v.why}"', style: theme.textTheme.bodyLarge),
          ],
          const SizedBox(height: 16),
          SectionCard(
            title: 'Progress',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${(v.progress * 100).round()}%',
                  style: theme.textTheme.displaySmall,
                ),
                const SizedBox(height: 8),
                LinearProgressIndicator(value: v.progress, minHeight: 8),
                const SizedBox(height: 12),
                Row(
                  children: [
                    if (v.targetValue != null)
                      Expanded(
                        child: StatTile(
                          label: 'Current',
                          value:
                              '${number(v.currentValue)} / '
                              '${number(v.targetValue!)} ${v.unit ?? ''}',
                        ),
                      ),
                    Expanded(
                      child: StatTile(
                        label: v.isCompleted ? 'Completed' : 'Deadline',
                        value: v.isCompleted
                            ? longDate(v.completedOn!)
                            : longDate(v.deadline),
                        caption: v.isCompleted
                            ? null
                            : daysLeft >= 0
                            ? '$daysLeft days left'
                            : '${-daysLeft} days past. Revise the plan?',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                StatTile(
                  label: 'Vision Points',
                  value: '$vpEarned of ${visionVp(v)} VP',
                  caption:
                      'Ambition ×${(v.ambition ?? 1).toStringAsFixed(1)}'
                      '${v.isCompleted ? '' : ' · +25% if finished on time'}',
                ),
                if (!v.isCompleted && v.targetValue != null) ...[
                  const SizedBox(height: 12),
                  OutlinedButton(
                    onPressed: () => _updateProgress(context, ref, v),
                    child: const Text('Update progress'),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 12),
          SectionCard(
            title: 'Milestones',
            child: v.milestones.isEmpty
                ? const EmptyState('No milestones. Add some by editing.')
                : Column(
                    children: [
                      for (final m in v.milestones)
                        CheckboxListTile(
                          contentPadding: EdgeInsets.zero,
                          value: m.isDone,
                          title: Text(m.title),
                          subtitle: m.isDone
                              ? Text('Reached ${shortDate(m.completedOn!)}')
                              : Text('+${milestoneVp(v)} VP'),
                          onChanged: m.isDone || v.isCompleted
                              ? null
                              : (_) => ref
                                    .read(growthServiceProvider)
                                    .completeMilestone(v, m),
                        ),
                    ],
                  ),
          ),
          const SizedBox(height: 12),
          SectionCard(
            title: 'Connected habits',
            child: habits.isEmpty
                ? const EmptyState(
                    'Link habits to this vision (edit a habit → Supports '
                    'vision) for a +0.5 XP bonus.',
                  )
                : Column(
                    children: [
                      for (final h in habits)
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: const Icon(Icons.flag_outlined),
                          title: Text(h.name),
                        ),
                    ],
                  ),
          ),
          if (!v.isCompleted) ...[
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: () => _complete(context, ref, v),
              icon: const Icon(Icons.emoji_events_outlined),
              label: const Text('Mark vision complete'),
            ),
          ],
        ],
      ),
    );
  }
}
