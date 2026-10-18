import 'package:flutter/material.dart';
import 'package:homework2/core/theme/app_colors.dart';
import 'package:homework2/core/theme/app_spacing.dart';

class AppTheme {
  static ThemeData get lightTheme => _build(Brightness.light);
  static ThemeData get darkTheme => _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final ColorScheme scheme = ColorScheme.fromSeed(
      seedColor: Colors.deepPurple,
      brightness: brightness,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      extensions: <ThemeExtension<dynamic>>[
        brightness == Brightness.dark ? AppColors.dark : AppColors.light,
      ],
      // Every filled button is at least 48 dp tall.
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size(64, AppSpacing.minTouchTarget),
        ),
      ),
    );
  }
}