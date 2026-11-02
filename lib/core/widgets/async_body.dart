import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Shows a spinner while loading, an error message on failure, otherwise
/// the result of [data].
class AsyncBody<T> extends StatelessWidget {
  const AsyncBody({super.key, required this.value, required this.data});

  final AsyncValue<T> value;
  final Widget Function(T value) data;

  @override
  Widget build(BuildContext context) => switch (value) {
    AsyncData(:final value) => data(value),
    AsyncError(:final error) => Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Text('Something went wrong: $error'),
      ),
    ),
    _ => const Center(child: CircularProgressIndicator()),
  };
}
