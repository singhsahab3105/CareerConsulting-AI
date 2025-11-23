import 'package:flutter/material.dart';

/// Central place for theming. If your guide/mentor asks to change colors,
/// you only need to update things here.
class AppTheme {
  static ThemeData light() {
    const seed = Color(0xFF344CB7); // bluish tone, looks formal but modern
    final scheme = ColorScheme.fromSeed(seedColor: seed);

    return ThemeData(
      colorScheme: scheme,
      useMaterial3: true,
      scaffoldBackgroundColor: scheme.surface,
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontWeight: FontWeight.bold,
        ),
        titleMedium: TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(),
        filled: true,
        fillColor: Color(0xFFF8F9FF),
      ),
    );
  }
}
