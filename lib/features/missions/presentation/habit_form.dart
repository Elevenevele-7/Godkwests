import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/clock.dart';
import '../../../core/database/sync_columns.dart';
import '../../../core/time/day.dart';
import '../../../core/widgets/format.dart';
import '../../profile/data/profile_repository.dart';
import '../../progression/domain/identity.dart';
import '../../visions/data/vision_repository.dart';
import '../data/habit_repository.dart';
import '../domain/habit.dart';

const difficultyLabels = {
  1: 'Very easy',
  2: 'Easy',
  3: 'Moderate',
  4: 'Hard',
  5: 'Very hard',
};

/// Create or edit a habit. Returns when saved or cancelled.
Future<void> showHabitForm(BuildContext context, {Habit? habit}) =>
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => HabitForm(habit: habit),
    );

class HabitForm extends ConsumerStatefulWidget {
  const HabitForm({super.key, this.habit});

  final Habit? habit;

  @override
  ConsumerState<HabitForm> createState() => _HabitFormState();
}

class _HabitFormState extends ConsumerState<HabitForm> {
  final _form = GlobalKey<FormState>();
  late final _name = TextEditingController(text: widget.habit?.name);
  late final _target = TextEditingController(
    text: widget.habit?.target?.toString(),
  );
  late final _unit = TextEditingController(text: widget.habit?.unit);
  late int _baseXp = widget.habit?.baseXp ?? 2;
  late Set<int> _weekdays = {...?widget.habit?.weekdays};
  late String? _area = widget.habit?.area;
  late String? _visionId = widget.habit?.visionId;

  @override
  void initState() {
    super.initState();
    if (_weekdays.isEmpty) _weekdays = {1, 2, 3, 4, 5, 6, 7};
  }

  @override
  void dispose() {
    _name.dispose();
    _target.dispose();
    _unit.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_form.currentState!.validate()) return;
    final today = ref.read(clockProvider)().dateOnly;
    final base = widget.habit;
    final habit = Habit(
      id: base?.id ?? newId(),
      name: _name.text.trim(),
      baseXp: _baseXp,
      weekdays: _weekdays,
      createdOn: base?.createdOn ?? today,
      area: _area,
      visionId: _visionId,
      target: int.tryParse(_target.text.trim()),
      unit: _unit.text.trim().isEmpty ? null : _unit.text.trim(),
      previousTarget: base?.previousTarget,
      previousBaseXp: base?.previousBaseXp,
      evolvedOn: base?.evolvedOn,
      evolveDeclinedOn: base?.evolveDeclinedOn,
    );
    await ref.read(habitRepositoryProvider).saveHabit(habit);
    if (mounted) Navigator.pop(context);
  }

  Future<void> _archive() async {
    final today = ref.read(clockProvider)().dateOnly;
    await ref
        .read(habitRepositoryProvider)
        .saveHabit(widget.habit!.copyWith(archivedOn: today));
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final profile = ref.watch(profileProvider).value;
    final visions = (ref.watch(visionsProvider).value ?? [])
        .where((v) => !v.isCompleted)
        .toList();
    final areas = {
      ...?profile?.areas.where((a) => a != financialResponsibility),
      ?_area,
    }.toList();
    if (areas.isEmpty) areas.addAll(suggestedAreas.take(3));

    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: MediaQuery.viewInsetsOf(context).bottom + 16,
      ),
      child: Form(
        key: _form,
        child: ListView(
          shrinkWrap: true,
          children: [
            Text(
              widget.habit == null ? 'New habit' : 'Edit habit',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _name,
              autofocus: widget.habit == null,
              textCapitalization: TextCapitalization.sentences,
              decoration: const InputDecoration(
                labelText: 'Mission',
                hintText: 'e.g. Read 20 pages',
              ),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Give it a name' : null,
            ),
            const SizedBox(height: 16),
            Text('Difficulty', style: Theme.of(context).textTheme.labelLarge),
            const SizedBox(height: 8),
            SegmentedButton<int>(
              showSelectedIcon: false,
              segments: [
                for (var i = 1; i <= 5; i++)
                  ButtonSegment(value: i, label: Text('$i')),
              ],
              selected: {_baseXp},
              onSelectionChanged: (s) => setState(() => _baseXp = s.first),
            ),
            const SizedBox(height: 4),
            Text(
              '${difficultyLabels[_baseXp]} · $_baseXp base XP',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 16),
            Text('Days', style: Theme.of(context).textTheme.labelLarge),
            const SizedBox(height: 8),
            Wrap(
              spacing: 6,
              children: [
                for (var d = 1; d <= 7; d++)
                  FilterChip(
                    label: Text(weekdayLetters[d - 1]),
                    selected: _weekdays.contains(d),
                    onSelected: (on) => setState(() {
                      on ? _weekdays.add(d) : _weekdays.remove(d);
                      if (_weekdays.isEmpty) _weekdays.add(d);
                    }),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _target,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Target (optional)',
                      hintText: '20',
                    ),
                    validator: (v) =>
                        (v != null &&
                            v.trim().isNotEmpty &&
                            int.tryParse(v.trim()) == null)
                        ? 'Whole number'
                        : null,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextFormField(
                    controller: _unit,
                    decoration: const InputDecoration(
                      labelText: 'Unit',
                      hintText: 'pages',
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              'A target lets the app offer harder challenges as you improve.',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String?>(
              isExpanded: true,
              initialValue: _area,
              decoration: const InputDecoration(labelText: 'Growth area'),
              items: [
                const DropdownMenuItem(value: null, child: Text('None')),
                for (final a in areas)
                  DropdownMenuItem(value: a, child: Text(a)),
              ],
              onChanged: (v) => setState(() => _area = v),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String?>(
              isExpanded: true,
              initialValue: visions.any((v) => v.id == _visionId)
                  ? _visionId
                  : null,
              decoration: const InputDecoration(
                labelText: 'Supports vision',
                helperText: 'Vision-linked habits earn a +0.5 XP bonus',
              ),
              items: [
                const DropdownMenuItem(value: null, child: Text('None')),
                for (final v in visions)
                  DropdownMenuItem(value: v.id, child: Text(v.title)),
              ],
              onChanged: (v) => setState(() => _visionId = v),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                if (widget.habit != null)
                  TextButton.icon(
                    onPressed: _archive,
                    icon: const Icon(Icons.archive_outlined),
                    label: const Text('Archive'),
                  ),
                const Spacer(),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                const SizedBox(width: 8),
                FilledButton(onPressed: _save, child: const Text('Save')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
