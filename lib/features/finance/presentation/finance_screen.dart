import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/widgets/async_body.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/format.dart';
import '../../../core/widgets/section_card.dart';
import '../../../core/widgets/stat_tile.dart';
import '../data/finance_repository.dart';
import '../data/finance_state.dart';
import '../domain/finance.dart';
import 'finance_forms.dart';

class FinanceScreen extends ConsumerWidget {
  const FinanceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(financeStateProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Finance'),
        actions: [
          if (state.value != null)
            IconButton(
              tooltip: 'Budget settings',
              icon: const Icon(Icons.tune),
              onPressed: () =>
                  showBudgetForm(context, current: state.value!.settings),
            ),
        ],
      ),
      floatingActionButton: state.value == null
          ? null
          : FloatingActionButton.extended(
              onPressed: () => showExpenseForm(context),
              icon: const Icon(Icons.remove_circle_outline),
              label: const Text('Spend'),
            ),
      body: AsyncBody(
        value: state,
        data: (f) => f == null ? const _SetUp() : _Overview(state: f),
      ),
    );
  }
}

void _noop() {}

class _SetUp extends StatelessWidget {
  const _SetUp();

  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.all(16),
    children: [
      Text(
        'Connect your money to your goals',
        style: Theme.of(context).textTheme.headlineSmall,
      ),
      const SizedBox(height: 8),
      const Text(
        'Set a weekly budget for essentials and fun, plus a daily savings '
        'target. The app turns it into a daily allowance, and every day you '
        'log and stay within it earns XP.',
      ),
      const SizedBox(height: 16),
      Card(
        child: Padding(
          padding: EdgeInsets.all(
            16,
          ), // Saving switches this tab to the overview by itself.
          child: BudgetForm(onSaved: _noop),
        ),
      ),
    ],
  );
}

class _Overview extends ConsumerWidget {
  const _Overview({required this.state});

  final FinanceState state;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final s = state.snapshot;
    final cur = state.settings.currency;
    final savings = ref.watch(savingsProvider).value ?? [];
    final statusColor = switch (s.status) {
      BudgetStatus.onTrack => theme.colorScheme.primary,
      BudgetStatus.overPace => theme.colorScheme.tertiary,
      BudgetStatus.overBudget => theme.colorScheme.error,
    };

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 96),
      children: [
        SectionCard(
          title: 'This week',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                      label: 'Fun budget today',
                      value: money(s.funToday, cur),
                      emphasis: true,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ProgressRow(
                label:
                    'Spent ${money(s.spent, cur)} of '
                    '${money(s.weeklyBudget, cur)}',
                value: s.weeklyBudget == 0
                    ? 0
                    : (s.spent / s.weeklyBudget).clamp(0, 1),
                trailing: s.status.label,
              ),
              Text(
                '${s.daysLeft} day${s.daysLeft == 1 ? '' : 's'} left · '
                '${money(s.remaining, cur)} remaining',
                style: theme.textTheme.bodySmall?.copyWith(color: statusColor),
              ),
              if (state.funBudgetReduced) ...[
                const SizedBox(height: 8),
                Text(
                  'Fun budget is ${money(s.funBudget, cur)} this week '
                  '(normally ${money(state.settings.funWeekly, cur)}) because '
                  'of last week\'s overspend. Stay within it all week to '
                  'restore it and earn +2 XP.',
                  style: theme.textTheme.bodySmall,
                ),
              ],
            ],
          ),
        ),
        const SizedBox(height: 12),
        SectionCard(
          title: 'Savings',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: StatTile(
                      label: 'Total saved',
                      value: money(state.savedTotal, cur),
                      emphasis: true,
                    ),
                  ),
                  Expanded(
                    child: StatTile(
                      label: 'Today',
                      value:
                          '${money(state.savedToday, cur)} / '
                          '${number(state.settings.dailySavingsTarget)}',
                      caption: state.savedTodayTarget ? 'Target reached' : null,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: () => showSavingForm(context),
                icon: const Icon(Icons.savings_outlined),
                label: const Text('Add to savings'),
              ),
              for (final d in savings.take(5))
                ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: Text(money(d.amount, cur)),
                  subtitle: Text(shortDate(d.day)),
                  trailing: IconButton(
                    tooltip: 'Delete',
                    icon: const Icon(Icons.delete_outline),
                    onPressed: () =>
                        ref.read(financeRepositoryProvider).deleteSaving(d.id),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        SectionCard(
          title: 'Spending this week',
          child: state.weekExpenses.isEmpty
              ? const EmptyState(
                  'Nothing logged yet. Log spending as it happens; every '
                  'day you log and stay within your allowance earns +1 XP.',
                )
              : Column(
                  children: [
                    for (final e in [
                      ...state.weekExpenses,
                    ]..sort((a, b) => b.day.compareTo(a.day)))
                      ListTile(
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        leading: Icon(
                          e.category == SpendCategory.fun
                              ? Icons.celebration_outlined
                              : Icons.shopping_basket_outlined,
                        ),
                        title: Text(money(e.amount, cur)),
                        subtitle: Text(
                          [
                            shortDate(e.day),
                            e.category.label,
                            if (e.note != null) e.note!,
                          ].join(' · '),
                        ),
                        trailing: IconButton(
                          tooltip: 'Delete',
                          icon: const Icon(Icons.delete_outline),
                          onPressed: () => ref
                              .read(financeRepositoryProvider)
                              .deleteExpense(e.id),
                        ),
                      ),
                  ],
                ),
        ),
        const SizedBox(height: 12),
        Text(
          'Your finance records stay on this device and are encrypted '
          'before any sync. Only "stayed within budget" results are used '
          'for XP.',
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
