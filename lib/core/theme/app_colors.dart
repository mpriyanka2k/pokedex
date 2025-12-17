import 'package:flutter/material.dart';

@immutable
class AppColors extends ThemeExtension<AppColors> {
  // Brand
  final Color primary;
  final Color primaryVariant;

  // Secondary
  final Color secondary;

  // Backgrounds
  final Color background;
  final Color scaffoldBackground;
  final Color surface;
  final Color card;

  // Text
  final Color textPrimary;
  final Color textSecondary;
  final Color textHint;

  // Status
  final Color success;
  final Color warning;
  final Color error;
  final Color info;

  // UI Elements
  final Color border;
  final Color shadow;

  // 🚀 NEW COLORS (add freely)
  final Color chipBackground;
  final Color divider;
  final Color gradientStart;
  final Color gradientEnd;

  const AppColors({
    required this.primary,
    required this.primaryVariant,
    required this.secondary,
    required this.background,
    required this.scaffoldBackground,
    required this.surface,
    required this.card,
    required this.textPrimary,
    required this.textSecondary,
    required this.textHint,
    required this.success,
    required this.warning,
    required this.error,
    required this.info,
    required this.border,
    required this.shadow,
    required this.chipBackground,
    required this.divider,
    required this.gradientStart,
    required this.gradientEnd,
  });

  @override
  AppColors copyWith({
    Color? primary,
    Color? primaryVariant,
    Color? secondary,
    Color? background,
    Color? scaffoldBackground,
    Color? surface,
    Color? card,
    Color? textPrimary,
    Color? textSecondary,
    Color? textHint,
    Color? success,
    Color? warning,
    Color? error,
    Color? info,
    Color? border,
    Color? shadow,
    Color? chipBackground,
    Color? divider,
    Color? gradientStart,
    Color? gradientEnd,
  }) {
    return AppColors(
      primary: primary ?? this.primary,
      primaryVariant: primaryVariant ?? this.primaryVariant,
      secondary: secondary ?? this.secondary,
      background: background ?? this.background,
      scaffoldBackground: scaffoldBackground ?? this.scaffoldBackground,
      surface: surface ?? this.surface,
      card: card ?? this.card,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textHint: textHint ?? this.textHint,
      success: success ?? this.success,
      warning: warning ?? this.warning,
      error: error ?? this.error,
      info: info ?? this.info,
      border: border ?? this.border,
      shadow: shadow ?? this.shadow,
      chipBackground: chipBackground ?? this.chipBackground,
      divider: divider ?? this.divider,
      gradientStart: gradientStart ?? this.gradientStart,
      gradientEnd: gradientEnd ?? this.gradientEnd,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;
    return AppColors(
      primary: Color.lerp(primary, other.primary, t)!,
      primaryVariant: Color.lerp(primaryVariant, other.primaryVariant, t)!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      background: Color.lerp(background, other.background, t)!,
      scaffoldBackground:
          Color.lerp(scaffoldBackground, other.scaffoldBackground, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      card: Color.lerp(card, other.card, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary:
          Color.lerp(textSecondary, other.textSecondary, t)!,
      textHint: Color.lerp(textHint, other.textHint, t)!,
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      error: Color.lerp(error, other.error, t)!,
      info: Color.lerp(info, other.info, t)!,
      border: Color.lerp(border, other.border, t)!,
      shadow: Color.lerp(shadow, other.shadow, t)!,
      chipBackground:
          Color.lerp(chipBackground, other.chipBackground, t)!,
      divider: Color.lerp(divider, other.divider, t)!,
      gradientStart:
          Color.lerp(gradientStart, other.gradientStart, t)!,
      gradientEnd: Color.lerp(gradientEnd, other.gradientEnd, t)!,
    );
  }
}

  AppColors light = AppColors(
  primary: Color(0xFF004B84),
  primaryVariant: Color(0xFF54ACEF),
  secondary: Color(0xFF625B71),

  background: Colors.white,
  scaffoldBackground: Colors.white,
  surface: Colors.white,
  card: Color(0xFFE3F2FD),

  textPrimary: Color(0xFF2A394D),
  textSecondary: Color(0xFF49454F),
  textHint: Color(0xFF9E9E9E),

  success: Color(0xFF4CAF50),
  warning: Color(0xFFFFA000),
  error: Color(0xFFB00020),
  info: Color(0xFF2196F3),

  border: Color(0xFFDDDDDD),
  shadow: Color(0x33000000),

  chipBackground: Color(0xFFE8F0FE),
  divider: Color(0xFFE0E0E0),
  gradientStart: Color(0xFF54ACEF),
  gradientEnd: Color(0xFF004B84),
);

  AppColors dark = AppColors(
  // Brand
  primary: Color(0xFF8AB4F8),          // Soft blue (good contrast)
  primaryVariant: Color(0xFF1A3A5F),   // Deep blue container
  secondary: Color(0xFFD0BCFF),

  // Backgrounds
  background: Color(0xFF121212),
  scaffoldBackground: Color(0xFF0F0F0F),
  surface: Color(0xFF1E1E1E),
  card: Color(0xFF1C2A3A),

  // Text
  textPrimary: Color(0xFFE6E6E6),
  textSecondary: Color(0xFFB0B0B0),
  textHint: Color(0xFF8A8A8A),

  // Status
  success: Color(0xFF81C784),
  warning: Color(0xFFFFD54F),
  error: Color(0xFFCF6679),
  info: Color(0xFF64B5F6),

  // UI Elements
  border: Color(0xFF2C2C2C),
  shadow: Color(0x66000000),

  // Extras
  chipBackground: Color(0xFF243447),
  divider: Color(0xFF2E2E2E),
  gradientStart: Color(0xFF1A3A5F),
  gradientEnd: Color(0xFF0D47A1),
);

extension ThemeX on BuildContext {
  AppColors get colors =>
      Theme.of(this).extension<AppColors>()!;
}