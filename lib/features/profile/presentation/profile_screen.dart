import 'package:flutter/material.dart';

import '../../../core/widgets/feature_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) => const FeatureScreen(
    title: 'Profile',
    summary: 'Scores, achievements, coaching and accountability settings will live here.',
  );
}
