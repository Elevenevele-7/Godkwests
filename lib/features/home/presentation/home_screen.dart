import 'package:flutter/material.dart';

import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/section_card.dart';

/// The Command Center. Section order follows blueprint §8: finance first,
/// then missions and identity, then visions, learning and the Council.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(
              'YOUR PERSONAL GROWTH SYSTEM',
              style: theme.textTheme.labelMedium,
            ),
            const SizedBox(height: 4),
            Text('Good morning', style: theme.textTheme.headlineMedium),
            Text(
              "Your future is shaped by today's decisions.",
              style: theme.textTheme.bodyMedium,
            ),
            for (final section in _sections) ...[
              const SizedBox(height: 16),
              SectionCard(
                title: section.title,
                onViewAll: section.hasViewAll ? () {} : null,
                child: EmptyState(section.emptyMessage),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

typedef _Section = ({String title, String emptyMessage, bool hasViewAll});

const List<_Section> _sections = [
  (
    title: 'Financial Snapshot',
    emptyMessage: 'Set up your budget to see your daily allowance, fun budget and savings.',
    hasViewAll: true,
  ),
  (
    title: "Today's Missions",
    emptyMessage: 'Your daily missions will appear here.',
    hasViewAll: false,
  ),
  (
    title: "Who You're Becoming",
    emptyMessage:
        'Choose the areas you want to grow in to track your identity progress.',
    hasViewAll: false,
  ),
  (
    title: 'Active Visions',
    emptyMessage:
        'Define your first vision to connect it to your habits and budget.',
    hasViewAll: true,
  ),
  (
    title: 'Continue Learning',
    emptyMessage: 'Import a book or start a learning path.',
    hasViewAll: false,
  ),
  (
    title: "Today's Council Insight",
    emptyMessage: 'Your chosen advisor will share an insight here.',
    hasViewAll: false,
  ),
];
