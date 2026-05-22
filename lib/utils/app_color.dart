import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color background = Color(0xFF0B1020);

  static const Color surface = Color(0xFF151B2D);

  static const Color primary = Color(0xFF8B5CF6);

  static const Color secondary = Color(0xFF22D3EE);

  static const Color textPrimary = Color(0xFFF8FAFC);

  static const Color textSecondary = Color(0xFF94A3B8);

  static const Color textMuted = Color(0xFF64748B);

  static const Color glass = Color(0x14FFFFFF);

  static const Color glassBorder = Color(0x1FFFFFFF);

  static const Color blurOverlay = Color(0x0DFFFFFF);

  static const Color card = Color(0xFF1A2238);

  static const Color elevatedCard = Color(0xFF202A44);

  static const Color divider = Color(0x1FFFFFFF);

  static const Color border = Color(0x26FFFFFF);

  static const Color purpleGlow = Color(0x668B5CF6);

  static const Color cyanGlow = Color(0x6622D3EE);

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF8B5CF6), Color(0xFF6D5EF9)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient surfaceGradient = LinearGradient(
    colors: [Color(0xFF151B2D), Color(0xFF1A2238)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient glowGradient = LinearGradient(
    colors: [Color(0x668B5CF6), Color(0x3322D3EE)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const Color success = Color(0xFF22C55E);

  static const Color warning = Color(0xFFF59E0B);

  static const Color error = Color(0xFFEF4444);

  static const Color info = Color(0xFF3B82F6);

  static const Color shadowDark = Color(0x66000000);

  static const Color shadowPurple = Color(0x338B5CF6);

  static const Color transparent = Colors.transparent;

  static const Color white = Colors.white;

  static const Color black = Colors.black;
}
