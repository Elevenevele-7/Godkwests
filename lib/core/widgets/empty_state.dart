import 'package:flutter/material.dart';

/// Shown wherever real user data is not available yet. The app never
/// displays made-up figures in place of a user's records.
class EmptyState extends StatelessWidget {
  const EmptyState(this.message, {super.key});

  final String message;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text(
      message,
      style: theme.textTheme.bodyMedium?.copyWith(
        color: theme.colorScheme.onSurfaceVariant,
      ),
    );
  }
}
