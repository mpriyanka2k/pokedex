import 'package:flutter/material.dart';
import 'package:pokedex/core/theme/app_colors.dart' as AppColors;

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      primary: AppColors.light.primary,
      primaryContainer: AppColors.light.primaryVariant,
      secondary: AppColors.light.secondary,
      background: AppColors.light.background,
      surface: AppColors.light.surface,
      error: AppColors.light.error,
    ),

    scaffoldBackgroundColor: AppColors.light.background,
    cardColor: AppColors.light.card,

    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.light.background,
      foregroundColor: AppColors.light.textPrimary,
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.light.card,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColors.light.card),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColors.light.card, width: 2),
      ),
    ),
    extensions: [AppColors.light],
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,

    colorScheme: ColorScheme.dark(
      primary: AppColors.dark.primary,
      primaryContainer: AppColors.dark.primaryVariant,
      secondary: AppColors.dark.secondary,
      background: AppColors.dark.background,
      surface: AppColors.dark.surface,
      error: AppColors.dark.error,
    ),

    scaffoldBackgroundColor: AppColors.dark.background,
    cardColor: AppColors.dark.card,

    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.dark.background,
      foregroundColor: AppColors.dark.textPrimary,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.dark.card,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColors.dark.card),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColors.dark.card, width: 2),
      ),
    ),
    extensions: [AppColors.dark],
  );
}
