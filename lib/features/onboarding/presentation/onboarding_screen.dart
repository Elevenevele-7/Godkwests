import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/clock.dart';
import '../../../core/database/sync_columns.dart';
import '../../../core/time/day.dart';
import '../../council/domain/advisor.dart';
import '../../finance/presentation/finance_forms.dart';
import '../../missions/data/habit_repository.dart';
import '../../missions/domain/habit.dart';
import '../../profile/data/profile_repository.dart';
import '../../profile/domain/profile.dart';
import '../../progression/domain/accountability_mode.dart';
import '../../progression/domain/identity.dart';
import '../../visions/presentation/vision_form.dart';

/// Starter routines offered on the last step.
const _starterHabits = [
  (
    name: 'Read 20 pages',
    xp: 2,
    target: 20,
    unit: 'pages',
    area: 'Lifelong learning',
  ),
  (
    name: 'Complete workout',
    xp: 3,
    target: null,
    unit: null,
    area: 'Health & fitness',
  ),
  (
    name: 'Save today\'s target',
    xp: 2,
    target: null,
    unit: null,
    area: financialResponsibility,
  ),
  (
    name: 'Plan tomorrow in 5 minutes',
    xp: 1,
    target: null,
    unit: null,
    area: 'Discipline',
  ),
  (
    name: 'Meditate 10 minutes',
    xp: 2,
    target: 10,
    unit: 'minutes',
    area: 'Mindfulness',
  ),
  (
    name: 'Walk 5,000 steps',
    xp: 2,
    target: 5000,
    unit: 'steps',
    area: 'Health & fitness',
  ),
];

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final _pages = PageController();
  final _name = TextEditingController();
  final _areas = <String>{
    'Discipline',
    financialResponsibility,
    'Lifelong learning',
  };
  var _mode = AccountabilityMode.balanced;
  var _advisor = Advisor.strategist;
  final _habits = <int>{0, 1, 2};
  var _step = 0;

  static const _steps = 6;

  @override
  void dispose() {
    _pages.dispose();
    _name.dispose();
    super.dispose();
  }

  void _next() {
    FocusScope.of(context).unfocus();
    if (_step < _steps - 1) {
      setState(() => _step++);
      _pages.animateToPage(
        _step,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
      );
    } else {
      _finish();
    }
  }

  void _back() {
    setState(() => _step--);
    _pages.animateToPage(
      _step,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
    );
  }

  Future<void> _finish() async {
    final today = ref.read(clockProvider)().dateOnly;
    final habits = ref.read(habitRepositoryProvider);
    for (final i in _habits) {
      final h = _starterHabits[i];
      await habits.saveHabit(
        Habit(
          id: newId(),
          name: h.name,
          baseXp: h.xp,
          weekdays: const {1, 2, 3, 4, 5, 6, 7},
          createdOn: today,
          target: h.target,
          unit: h.unit,
          area: _areas.contains(h.area) ? h.area : null,
        ),
      );
    }
    await ref
        .read(profileRepositoryProvider)
        .save(
          Profile(
            displayName: _name.text.trim(),
            mode: _mode,
            areas: _areas.toList(),
            advisor: _advisor,
            onboarded: true,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final skippable = _step == 3 || _step == 4;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: LinearProgressIndicator(value: (_step + 1) / _steps),
            ),
            Expanded(
              child: PageView(
                controller: _pages,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _page(
                    'You choose who you want to become.',
                    'The system helps you become that person and shows you '
                        'how far you\'ve come.',
                    TextField(
                      controller: _name,
                      textCapitalization: TextCapitalization.words,
                      decoration: const InputDecoration(
                        labelText: 'What should we call you?',
                      ),
                    ),
                  ),
                  _page(
                    'What do you want to grow in?',
                    'Pick the areas that matter to you. Your Life Score only '
                        'counts these. There\'s no universal definition of '
                        'success.',
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        for (final a in suggestedAreas)
                          FilterChip(
                            label: Text(a),
                            selected: _areas.contains(a),
                            onSelected: (on) => setState(
                              () => on ? _areas.add(a) : _areas.remove(a),
                            ),
                          ),
                      ],
                    ),
                  ),
                  _page(
                    'How strict should the app be?',
                    'Penalties are always explained and always have a '
                        'recovery path. You can change this any time.',
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (final m in AccountabilityMode.values)
                          RadioListTile(
                            value: m,
                            groupValue: _mode,
                            onChanged: (v) => setState(() => _mode = v!),
                            title: Text(m.label),
                            subtitle: Text(m.description),
                          ),
                        const SizedBox(height: 16),
                        DropdownButtonFormField<Advisor>(
                          initialValue: _advisor,
                          decoration: const InputDecoration(
                            labelText: 'Choose your coach',
                          ),
                          items: [
                            for (final a in Advisor.values)
                              DropdownMenuItem(value: a, child: Text(a.title)),
                          ],
                          onChanged: (a) => setState(() => _advisor = a!),
                        ),
                        const SizedBox(height: 4),
                        Text(_advisor.focus, style: theme.textTheme.bodySmall),
                      ],
                    ),
                  ),
                  _page(
                    'Your first vision',
                    'A long-term goal ties your habits, money and learning '
                        'together. You can skip this and add one later.',
                    SizedBox(height: 520, child: VisionForm(onSaved: _next)),
                  ),
                  _page(
                    'Your weekly budget',
                    'Finance is a first-class part of growth. Optional: you '
                        'can set it up later in the Finance tab.',
                    BudgetForm(onSaved: _next),
                  ),
                  _page(
                    'Starting routines',
                    'Begin small. You can add, edit or remove habits any time.',
                    Column(
                      children: [
                        for (final (i, h) in _starterHabits.indexed)
                          CheckboxListTile(
                            contentPadding: EdgeInsets.zero,
                            value: _habits.contains(i),
                            title: Text(h.name),
                            subtitle: Text('${h.xp} base XP · ${h.area}'),
                            onChanged: (on) => setState(
                              () => on! ? _habits.add(i) : _habits.remove(i),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  if (_step > 0)
                    TextButton(onPressed: _back, child: const Text('Back')),
                  const Spacer(),
                  if (skippable)
                    TextButton(onPressed: _next, child: const Text('Skip'))
                  else
                    FilledButton(
                      onPressed: _next,
                      child: Text(_step == _steps - 1 ? 'Start' : 'Next'),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _page(String title, String body, Widget child) => ListView(
    padding: const EdgeInsets.all(24),
    children: [
      Text(title, style: Theme.of(context).textTheme.headlineSmall),
      const SizedBox(height: 8),
      Text(body),
      const SizedBox(height: 24),
      child,
    ],
  );
}
