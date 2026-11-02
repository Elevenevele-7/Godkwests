import 'package:flutter_riverpod/flutter_riverpod.dart';

/// The current time. Overridden in tests to pin "today".
final clockProvider = Provider<DateTime Function()>((ref) => DateTime.now);
