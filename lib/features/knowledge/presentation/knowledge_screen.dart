import 'package:flutter/material.dart';

import '../../../core/widgets/feature_screen.dart';

class KnowledgeScreen extends StatelessWidget {
  const KnowledgeScreen({super.key});

  @override
  Widget build(BuildContext context) => const FeatureScreen(
    title: 'Knowledge',
    summary: 'Your library, reader, highlights, notes and learning paths will live here.',
  );
}
