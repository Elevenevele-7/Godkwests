import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router.dart';
import '../../../core/widgets/async_body.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/format.dart';
import '../../../core/widgets/section_card.dart';
import '../../../core/widgets/stat_tile.dart';
import '../../council/domain/advisor.dart';
import '../../progression/data/growth_state.dart';
import '../../progression/domain/accountability_mode.dart';
import '../../progression/domain/identity.dart';
import '../../progression/domain/reward.dart';
import '../../sync/presentation/account_card.dart';
import '../data/profile_repository.dart';
import '../domain/profile.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: AsyncBody(
        value: ref.watch(growthStateProvider),
        data: (s) => ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _Stats(state: s),
            const SizedBox(height: 12),
            ListTile(
              tileColor: Theme.of(context).colorScheme.surfaceContainerLow,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              leading: const Icon(Icons.flag_circle_outlined),
              title: const Text('Visions'),
              subtitle: const Text('Active goals and your permanent record'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => context.push(Routes.visions),
            ),
            const SizedBox(height: 12),
            _Settings(profile: s.profile),
            const SizedBox(height: 12),
            const AccountCard(),
            const SizedBox(height: 12),
            _History(rewards: s.rewards),
          ],
        ),
      ),
    );
  }
}

class _Stats extends StatelessWidget {
  const _Stats({required this.state});

  final GrowthState state;

  @override
  Widget build(BuildContext context) => SectionCard(
    title: 'Your progress',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 24,
          runSpacing: 12,
          children: [
            StatTile(
              label: 'Level',
              value: '${state.level.level}',
              emphasis: true,
              caption:
                  '${state.level.xpIntoLevel}/${state.level.xpForNextLevel} XP',
            ),
            StatTile(label: 'Total XP', value: number(state.totals.xp)),
            StatTile(label: 'Discipline Points', value: '${state.totals.dp}'),
            StatTile(label: 'Vision Points', value: '${state.totals.vp}'),
          ],
        ),
        const SizedBox(height: 12),
        ProgressRow(label: 'Discipline Score', value: state.discipline / 100),
        ProgressRow(label: 'Momentum', value: state.momentum / 100),
        if (state.lifeScore != null)
          ProgressRow(label: 'Life Score', value: state.lifeScore! / 100),
        const SizedBox(height: 4),
        Text(
          'Discipline: scheduled missions done in the last 30 days. '
          'Momentum: the last 7 days, recent days counting most.',
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    ),
  );
}

class _Settings extends ConsumerWidget {
  const _Settings({required this.profile});

  final Profile profile;

  Future<void> _save(WidgetRef ref, Profile p) =>
      ref.read(profileRepositoryProvider).save(p);

  Future<void> _editName(BuildContext context, WidgetRef ref) async {
    final c = TextEditingController(text: profile.displayName);
    final name = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Your name'),
        content: TextField(controller: c, autofocus: true),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, c.text.trim()),
            child: const Text('Save'),
          ),
        ],
      ),
    );
    c.dispose();
    if (name != null) await _save(ref, profile.copyWith(displayName: name));
  }

  Future<void> _editAreas(BuildContext context, WidgetRef ref) async {
    final chosen = {...profile.areas};
    final result = await showDialog<Set<String>>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Growth areas'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (final a in {...suggestedAreas, ...profile.areas})
                  CheckboxListTile(
                    value: chosen.contains(a),
                    title: Text(a),
                    onChanged: (on) =>
                        setState(() => on! ? chosen.add(a) : chosen.remove(a)),
                  ),
              ],
            ),
          ),
          actions: [
            FilledButton(
              onPressed: () => Navigator.pop(context, chosen),
              child: const Text('Done'),
            ),
          ],
        ),
      ),
    );
    if (result != null) {
      await _save(ref, profile.copyWith(areas: result.toList()));
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) => SectionCard(
    title: 'Settings',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Name'),
          subtitle: Text(
            profile.displayName.isEmpty ? 'Not set' : profile.displayName,
          ),
          onTap: () => _editName(context, ref),
        ),
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Growth areas'),
          subtitle: Text(
            profile.areas.isEmpty ? 'None chosen' : profile.areas.join(', '),
          ),
          onTap: () => _editAreas(context, ref),
        ),
        const SizedBox(height: 8),
        Text('Accountability', style: Theme.of(context).textTheme.labelLarge),
        const SizedBox(height: 8),
        SegmentedButton<AccountabilityMode>(
          segments: [
            for (final m in AccountabilityMode.values)
              ButtonSegment(value: m, label: Text(m.label)),
          ],
          selected: {profile.mode},
          onSelectionChanged: (s) =>
              _save(ref, profile.copyWith(mode: s.first)),
        ),
        const SizedBox(height: 4),
        Text(
          profile.mode.description,
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(height: 16),
        DropdownButtonFormField<Advisor>(
          isExpanded: true,
          initialValue: profile.advisor,
          decoration: const InputDecoration(labelText: 'Your coach'),
          items: [
            for (final a in Advisor.values)
              DropdownMenuItem(value: a, child: Text(a.title)),
          ],
          onChanged: (a) => _save(ref, profile.copyWith(advisor: a)),
        ),
        const SizedBox(height: 12),
        Text(
          'Coaching style: ${strictnessLabels[profile.strictness]}',
          style: Theme.of(context).textTheme.labelLarge,
        ),
        Slider(
          value: profile.strictness.toDouble(),
          min: 1,
          max: 3,
          divisions: 2,
          label: strictnessLabels[profile.strictness],
          onChanged: (v) => _save(ref, profile.copyWith(strictness: v.round())),
        ),
      ],
    ),
  );
}

const strictnessLabels = {1: 'Supportive', 2: 'Balanced', 3: 'Direct'};

class _History extends StatelessWidget {
  const _History({required this.rewards});

  final List<Reward> rewards;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SectionCard(
      title: 'History',
      child: rewards.isEmpty
          ? const EmptyState(
              'Every XP, DP and VP you earn or lose is listed here with the '
              'reason.',
            )
          : Column(
              children: [
                for (final r in rewards.take(50))
                  ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    title: Text(r.explanation),
                    subtitle: Text(shortDate(r.day)),
                    trailing: Text(
                      '${r.amount >= 0 ? '+' : ''}${r.amount} '
                      '${r.currency.name.toUpperCase()}',
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: r.amount < 0
                            ? theme.colorScheme.error
                            : theme.colorScheme.primary,
                      ),
                    ),
                  ),
              ],
            ),
    );
  }
}
