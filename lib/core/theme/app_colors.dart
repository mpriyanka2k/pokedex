import 'package:flutter/material.dart';

class AppColors {
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
  });

  // -------------------------
  // ☀️ LIGHT THEME COLORS
  // -------------------------
  static const AppColors light = AppColors(
    primary: Color(0xFF004B84),
    primaryVariant: Color(0xFF54ACEF),
    secondary: Color(0xFF625B71),

    background: Color(0xFFFFFFFF),
    scaffoldBackground: Color(0xFFFFFFFF),
    surface: Color(0xFFFFFFFF),
    card: Color.fromARGB(255, 140, 181, 234),

    textPrimary: Color(0xFF2A394D),
    textSecondary: Color(0xFF49454F),
    textHint: Color(0xFF9E9E9E),

    success: Color(0xFF4CAF50),
    warning: Color(0xFFFFA000),
    error: Color(0xFFB00020),
    info: Color(0xFF2196F3),

    border: Color(0xFFDDDDDD),
    shadow: Color(0x33000000),
  );

  // -------------------------
  // 🌙 DARK THEME COLORS
  // -------------------------
  static const AppColors dark = AppColors(
    primary: Color(0xFF9F7BD9),
    primaryVariant: Color(0xFF4E3A86),
    secondary: Color(0xFFECE5F9),

    background: Color(0xFF121212),
    scaffoldBackground: Color(0xFF000000),
    surface: Color(0xFF1E1E1E),
    card: Color(0xFF2A394D),

    textPrimary: Colors.white,
    textSecondary: Color(0xFFB0B0B0),
    textHint: Color(0xFF757575),

    success: Color(0xFF66BB6A),
    warning: Color(0xFFFFB74D),
    error: Color(0xFFCF6679),
    info: Color(0xFF64B5F6),

    border: Color(0xFF333333),
    shadow: Color(0x66000000),
  );
}
