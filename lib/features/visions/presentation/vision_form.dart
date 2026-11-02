import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/clock.dart';
import '../../../core/database/sync_columns.dart';
import '../../../core/time/day.dart';
import '../../../core/widgets/format.dart';
import '../../progression/data/growth_service.dart';
import '../data/vision_repository.dart';
import '../domain/vision.dart';
import '../domain/vision_points.dart';

/// Create a vision, or edit an unfinished one.
Future<void> showVisionForm(BuildContext context, {Vision? vision}) =>
    Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) => VisionForm(vision: vision),
      ),
    );

class VisionForm extends ConsumerStatefulWidget {
  const VisionForm({super.key, this.vision, this.onSaved});

  final Vision? vision;

  /// Replaces closing the page after saving (used in onboarding).
  final VoidCallback? onSaved;

  @override
  ConsumerState<VisionForm> createState() => _VisionFormState();
}

class _VisionFormState extends ConsumerState<VisionForm> {
  final _form = GlobalKey<FormState>();
  late final _title = TextEditingController(text: widget.vision?.title);
  late final _why = TextEditingController(text: widget.vision?.why);
  late final _target = TextEditingController(
    text: widget.vision?.targetValue?.toStringAsFixed(0),
  );
  late final _unit = TextEditingController(text: widget.vision?.unit ?? 'KSh');
  late var _category = widget.vision?.category ?? VisionCategory.finance;
  late DateTime _deadline;
  late final List<TextEditingController> _milestones = [
    for (final m in widget.vision?.milestones ?? const <Milestone>[])
      TextEditingController(text: m.title),
  ];

  @override
  void initState() {
    super.initState();
    _deadline =
        widget.vision?.deadline ??
        ref.read(clockProvider)().dateOnly.addDays(182);
  }

  @override
  void dispose() {
    for (final c in [_title, _why, _target, _unit, ..._milestones]) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _pickDeadline() async {
    final today = ref.read(clockProvider)().dateOnly;
    final picked = await showDatePicker(
      context: context,
      initialDate: _deadline,
      firstDate: today.addDays(1),
      lastDate: today.addDays(365 * 10),
    );
    if (picked != null) setState(() => _deadline = picked.dateOnly);
  }

  Future<void> _save() async {
    if (!_form.currentState!.validate()) return;
    final today = ref.read(clockProvider)().dateOnly;
    final existing = widget.vision;
    final oldMilestones = existing?.milestones ?? const <Milestone>[];
    final milestones = [
      for (final (i, c) in _milestones.indexed)
        if (c.text.trim().isNotEmpty)
          i < oldMilestones.length
              ? Milestone(
                  id: oldMilestones[i].id,
                  title: c.text.trim(),
                  completedOn: oldMilestones[i].completedOn,
                )
              : Milestone(id: newId(), title: c.text.trim()),
    ];
    final vision = Vision(
      id: existing?.id ?? newId(),
      title: _title.text.trim(),
      why: _why.text.trim().isEmpty ? null : _why.text.trim(),
      category: _category,
      targetValue: double.tryParse(_target.text.trim()),
      unit: _unit.text.trim().isEmpty ? null : _unit.text.trim(),
      currentValue: existing?.currentValue ?? 0,
      startedOn: existing?.startedOn ?? today,
      deadline: _deadline,
      milestones: milestones,
      ambition: existing?.ambition,
    );
    if (existing == null) {
      await ref.read(growthServiceProvider).createVision(vision);
    } else {
      await ref.read(visionRepositoryProvider).save(vision);
    }
    if (widget.onSaved != null) {
      widget.onSaved!();
    } else if (mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final today = ref.watch(clockProvider)().dateOnly;
    final months = monthsPlanned(widget.vision?.startedOn ?? today, _deadline);
    final form = Form(
      key: _form,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextFormField(
            controller: _title,
            textCapitalization: TextCapitalization.sentences,
            decoration: const InputDecoration(
              labelText: 'Vision',
              hintText: 'e.g. Build an emergency fund',
            ),
            validator: (v) =>
                (v == null || v.trim().isEmpty) ? 'Name your vision' : null,
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _why,
            maxLines: 3,
            minLines: 1,
            textCapitalization: TextCapitalization.sentences,
            decoration: const InputDecoration(
              labelText: 'Why it matters',
              hintText: 'Your reason keeps you going on hard days',
            ),
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<VisionCategory>(
            initialValue: _category,
            decoration: const InputDecoration(labelText: 'Category'),
            items: [
              for (final c in VisionCategory.values)
                DropdownMenuItem(value: c, child: Text(c.label)),
            ],
            onChanged: (c) => setState(() => _category = c!),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: TextFormField(
                  controller: _target,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Target (optional)',
                    hintText: '100000',
                  ),
                  validator: (v) =>
                      (v != null &&
                          v.trim().isNotEmpty &&
                          double.tryParse(v.trim()) == null)
                      ? 'Number'
                      : null,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextFormField(
                  controller: _unit,
                  decoration: const InputDecoration(labelText: 'Unit'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.event_outlined),
            title: Text('Deadline: ${longDate(_deadline)}'),
            subtitle: Text(
              '$months month${months == 1 ? '' : 's'} · about '
              '${10 * months} VP before ambition and on-time bonus',
            ),
            onTap: _pickDeadline,
          ),
          const SizedBox(height: 8),
          Text('Milestones', style: Theme.of(context).textTheme.titleSmall),
          const Text('Each milestone you reach earns a share of the VP.'),
          for (final (i, c) in _milestones.indexed)
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: c,
                    decoration: InputDecoration(
                      labelText: 'Milestone ${i + 1}',
                    ),
                  ),
                ),
                if (!(widget.vision?.milestones.elementAtOrNull(i)?.isDone ??
                    false))
                  IconButton(
                    tooltip: 'Remove',
                    icon: const Icon(Icons.close),
                    onPressed: () => setState(() {
                      _milestones.removeAt(i).dispose();
                    }),
                  ),
              ],
            ),
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton.icon(
              onPressed: () =>
                  setState(() => _milestones.add(TextEditingController())),
              icon: const Icon(Icons.add),
              label: const Text('Add milestone'),
            ),
          ),
          if (widget.onSaved != null) ...[
            const SizedBox(height: 16),
            FilledButton(onPressed: _save, child: const Text('Save vision')),
          ],
        ],
      ),
    );

    if (widget.onSaved != null) return form;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.vision == null ? 'New vision' : 'Edit vision'),
        actions: [TextButton(onPressed: _save, child: const Text('Save'))],
      ),
      body: form,
    );
  }
}
