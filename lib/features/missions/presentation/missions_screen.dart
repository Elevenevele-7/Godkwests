import 'package:flutter/material.dart';

import '../../../core/widgets/feature_screen.dart';

class MissionsScreen extends StatelessWidget {
  const MissionsScreen({super.key});

  @override
  Widget build(BuildContext context) => const FeatureScreen(
    title: 'Missions',
    summary: 'Daily missions, habits, streaks and challenges will live here.',
  );
}
