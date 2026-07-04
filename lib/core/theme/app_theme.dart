import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_typography.dart';

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.background, // Matte Slate
      colorScheme: const ColorScheme.dark(
        surface: AppColors.matteBlack,
        primary: AppColors.alabaster,
        onSurface: AppColors.alabaster,
        onSurfaceVariant: Colors.white24, // for grid, etc
      ),
      textTheme: AppTypography.textTheme(Brightness.dark),
    );
  }

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.alabaster,
      colorScheme: const ColorScheme.light(
        surface: AppColors.alabasterCard,
        primary: AppColors.matteBlack,
        onSurface: AppColors.matteBlack,
        onSurfaceVariant: Colors.black12,
      ),
      textTheme: AppTypography.textTheme(Brightness.light),
    );
  }
}
