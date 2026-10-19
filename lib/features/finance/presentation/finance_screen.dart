import 'package:flutter/material.dart';

import '../../../core/widgets/feature_screen.dart';

class FinanceScreen extends StatelessWidget {
  const FinanceScreen({super.key});

  @override
  Widget build(BuildContext context) => const FeatureScreen(
    title: 'Finance',
    summary: 'Budgets, allowances, savings goals and accountability settings will live here.',
  );
}
