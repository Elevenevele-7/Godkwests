import 'package:flutter/material.dart';

import 'empty_state.dart';

/// Scaffold for a tab whose feature is not built yet.
class FeatureScreen extends StatelessWidget {
  const FeatureScreen({super.key, required this.title, required this.summary});

  final String title;
  final String summary;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: EmptyState(summary),
      ),
    );
  }
}
