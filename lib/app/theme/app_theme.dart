import 'package:flutter/material.dart';

abstract final class AppTheme {
  static const _seed = Color(0xFF2E5BFF);

  static ThemeData get light => _build(Brightness.light);
  static ThemeData get dark => _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final scheme = ColorScheme.fromSeed(
      seedColor: _seed,
      brightness: brightness,
    );
    return ThemeData(
      colorScheme: scheme,
      useMaterial3: true,
      cardTheme: const CardThemeData(elevation: 0, margin: EdgeInsets.zero),
    );
  }
}
