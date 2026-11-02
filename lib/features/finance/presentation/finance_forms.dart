import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/clock.dart';
import '../../../core/database/sync_columns.dart';
import '../../../core/time/day.dart';
import '../../visions/data/vision_repository.dart';
import '../data/finance_repository.dart';
import '../domain/finance.dart';

Future<void> _sheet(BuildContext context, Widget child) => showModalBottomSheet(
  context: context,
  isScrollControlled: true,
  useSafeArea: true,
  builder: (context) => Padding(
    padding: EdgeInsets.only(
      left: 16,
      right: 16,
      top: 16,
      bottom: MediaQuery.viewInsetsOf(context).bottom + 16,
    ),
    child: child,
  ),
);

final _digits = [FilteringTextInputFormatter.digitsOnly];

String? _amountValidator(String? v) =>
    (int.tryParse(v ?? '') ?? 0) <= 0 ? 'Enter an amount' : null;

String? _wholeValidator(String? v) =>
    int.tryParse(v ?? '') == null ? 'Enter a number (0 is fine)' : null;

// Expense

Future<void> showExpenseForm(BuildContext context) =>
    _sheet(context, const _ExpenseForm());

class _ExpenseForm extends ConsumerStatefulWidget {
  const _ExpenseForm();

  @override
  ConsumerState<_ExpenseForm> createState() => _ExpenseFormState();
}

class _ExpenseFormState extends ConsumerState<_ExpenseForm> {
  final _form = GlobalKey<FormState>();
  final _amount = TextEditingController();
  final _note = TextEditingController();
  var _category = SpendCategory.essential;

  @override
  void dispose() {
    _amount.dispose();
    _note.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_form.currentState!.validate()) return;
    await ref
        .read(financeRepositoryProvider)
        .addExpense(
          Expense(
            id: newId(),
            amount: int.parse(_amount.text),
            category: _category,
            day: ref.read(clockProvider)().dateOnly,
            note: _note.text.trim().isEmpty ? null : _note.text.trim(),
          ),
        );
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) => Form(
    key: _form,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Log spending', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 16),
        TextFormField(
          controller: _amount,
          autofocus: true,
          keyboardType: TextInputType.number,
          inputFormatters: _digits,
          decoration: const InputDecoration(labelText: 'Amount'),
          validator: _amountValidator,
        ),
        const SizedBox(height: 12),
        SegmentedButton<SpendCategory>(
          segments: [
            for (final c in SpendCategory.values)
              ButtonSegment(value: c, label: Text(c.label)),
          ],
          selected: {_category},
          onSelectionChanged: (s) => setState(() => _category = s.first),
        ),
        const SizedBox(height: 4),
        Text(
          _category == SpendCategory.essential
              ? 'Food, rent, transport, bills: things you need.'
              : 'Entertainment and treats, paid from your fun budget.',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(height: 12),
        TextFormField(
          controller: _note,
          decoration: const InputDecoration(labelText: 'Note (optional)'),
        ),
        const SizedBox(height: 16),
        FilledButton(onPressed: _save, child: const Text('Save')),
      ],
    ),
  );
}

// Saving

Future<void> showSavingForm(BuildContext context) =>
    _sheet(context, const _SavingForm());

class _SavingForm extends ConsumerStatefulWidget {
  const _SavingForm();

  @override
  ConsumerState<_SavingForm> createState() => _SavingFormState();
}

class _SavingFormState extends ConsumerState<_SavingForm> {
  final _form = GlobalKey<FormState>();
  final _amount = TextEditingController();
  String? _visionId;

  @override
  void dispose() {
    _amount.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_form.currentState!.validate()) return;
    final amount = int.parse(_amount.text);
    await ref
        .read(financeRepositoryProvider)
        .addSaving(
          SavingsDeposit(
            id: newId(),
            amount: amount,
            day: ref.read(clockProvider)().dateOnly,
            visionId: _visionId,
          ),
        );
    // A saving toward a money vision also moves that vision forward.
    final vision = (ref.read(visionsProvider).value ?? [])
        .where((v) => v.id == _visionId)
        .firstOrNull;
    if (vision != null) {
      await ref
          .read(visionRepositoryProvider)
          .save(vision.copyWith(currentValue: vision.currentValue + amount));
    }
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final visions = (ref.watch(visionsProvider).value ?? [])
        .where((v) => !v.isCompleted && v.targetValue != null)
        .toList();
    return Form(
      key: _form,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Add to savings', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 16),
          TextFormField(
            controller: _amount,
            autofocus: true,
            keyboardType: TextInputType.number,
            inputFormatters: _digits,
            decoration: const InputDecoration(labelText: 'Amount saved'),
            validator: _amountValidator,
          ),
          if (visions.isNotEmpty) ...[
            const SizedBox(height: 12),
            DropdownButtonFormField<String?>(
              isExpanded: true,
              initialValue: _visionId,
              decoration: const InputDecoration(labelText: 'Toward vision'),
              items: [
                const DropdownMenuItem(value: null, child: Text('General')),
                for (final v in visions)
                  DropdownMenuItem(value: v.id, child: Text(v.title)),
              ],
              onChanged: (v) => setState(() => _visionId = v),
            ),
          ],
          const SizedBox(height: 16),
          FilledButton(onPressed: _save, child: const Text('Save')),
        ],
      ),
    );
  }
}

// Budget settings

Future<void> showBudgetForm(BuildContext context, {FinanceSettings? current}) =>
    _sheet(context, BudgetForm(current: current));

class BudgetForm extends ConsumerStatefulWidget {
  const BudgetForm({super.key, this.current, this.onSaved});

  final FinanceSettings? current;

  /// Called after saving instead of closing the sheet (used in onboarding).
  final VoidCallback? onSaved;

  @override
  ConsumerState<BudgetForm> createState() => _BudgetFormState();
}

class _BudgetFormState extends ConsumerState<BudgetForm> {
  final _form = GlobalKey<FormState>();
  late final _essentials = TextEditingController(
    text: widget.current?.essentialsWeekly.toString(),
  );
  late final _fun = TextEditingController(
    text: widget.current?.funWeekly.toString(),
  );
  late final _savings = TextEditingController(
    text: widget.current?.dailySavingsTarget.toString(),
  );
  late var _penalties = widget.current?.penaltiesEnabled ?? false;

  @override
  void dispose() {
    _essentials.dispose();
    _fun.dispose();
    _savings.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_form.currentState!.validate()) return;
    await ref
        .read(financeRepositoryProvider)
        .saveSettings(
          FinanceSettings(
            essentialsWeekly: int.parse(_essentials.text),
            funWeekly: int.parse(_fun.text),
            dailySavingsTarget: int.parse(_savings.text),
            penaltiesEnabled: _penalties,
          ),
        );
    if (widget.onSaved != null) {
      widget.onSaved!();
    } else if (mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) => Form(
    key: _form,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Weekly budget', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 4),
        const Text('Weeks run Monday to Sunday. Amounts in KSh.'),
        const SizedBox(height: 16),
        TextFormField(
          controller: _essentials,
          keyboardType: TextInputType.number,
          inputFormatters: _digits,
          decoration: const InputDecoration(
            labelText: 'Essentials per week',
            helperText: 'Food, transport, bills',
          ),
          validator: _wholeValidator,
        ),
        const SizedBox(height: 12),
        TextFormField(
          controller: _fun,
          keyboardType: TextInputType.number,
          inputFormatters: _digits,
          decoration: const InputDecoration(
            labelText: 'Fun budget per week',
            helperText: 'Entertainment and treats',
          ),
          validator: _wholeValidator,
        ),
        const SizedBox(height: 12),
        TextFormField(
          controller: _savings,
          keyboardType: TextInputType.number,
          inputFormatters: _digits,
          decoration: const InputDecoration(
            labelText: 'Savings target per day',
          ),
          validator: _wholeValidator,
        ),
        const SizedBox(height: 8),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          value: _penalties,
          onChanged: (v) => setState(() => _penalties = v),
          title: const Text('Overspending shrinks next week\'s fun budget'),
          subtitle: const Text(
            'Optional. Never below half, and essentials and savings are '
            'never touched. Keep the reduced budget for a week to restore it '
            'and earn +2 XP.',
          ),
        ),
        const SizedBox(height: 16),
        FilledButton(onPressed: _save, child: const Text('Save budget')),
      ],
    ),
  );
}
