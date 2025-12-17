

import 'package:flutter/material.dart';
import 'package:pokedex/core/theme/app_colors.dart';

extension ThemeX on BuildContext {
  AppColors get colors =>
      Theme.of(this).extension<AppColors>()!;
}


const AppColors light = AppColors(
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


 const AppColors dark = AppColors(
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



