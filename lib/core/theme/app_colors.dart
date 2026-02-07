import 'package:flutter/material.dart';

abstract final class AppColors {
  // ─── Brand / Primary ───
  static const Color primaryLight = Color(0xFF6C63FF);
  static const Color primaryDark = Color(0xFF9D97FF);
  static const Color onPrimaryLight = Colors.white;
  static const Color onPrimaryDark = Color(0xFF1A1A2E);

  // ─── Secondary ───
  static const Color secondaryLight = Color(0xFF03DAC6);
  static const Color secondaryDark = Color(0xFF03DAC6);
  static const Color onSecondaryLight = Color(0xFF1A1A2E);
  static const Color onSecondaryDark = Color(0xFF1A1A2E);

  // ─── Background / Surface ───
  static const Color backgroundLight = Color(0xFFF8F9FE);
  static const Color backgroundDark = Color(0xFF121212);
  static const Color surfaceLight = Colors.white;
  static const Color surfaceDark = Color(0xFF1E1E2E);
  static const Color surfaceVariantLight = Color(0xFFF0F0F8);
  static const Color surfaceVariantDark = Color(0xFF2A2A3C);

  // ─── On Background / Surface ───
  static const Color onBackgroundLight = Color(0xFF1A1A2E);
  static const Color onBackgroundDark = Color(0xFFE8E8F0);
  static const Color onSurfaceLight = Color(0xFF1A1A2E);
  static const Color onSurfaceDark = Color(0xFFE8E8F0);
  static const Color onSurfaceVariantLight = Color(0xFF5A5A72);
  static const Color onSurfaceVariantDark = Color(0xFFA0A0B8);

  // ─── Error ───
  static const Color errorLight = Color(0xFFB00020);
  static const Color errorDark = Color(0xFFCF6679);
  static const Color onErrorLight = Colors.white;
  static const Color onErrorDark = Color(0xFF1A1A2E);

  // ─── Outline / Divider ───
  static const Color outlineLight = Color(0xFFD8D8E8);
  static const Color outlineDark = Color(0xFF3A3A4C);

  // ─── App-specific semantic colors ───
  static const Color chatBubbleUserLight = Color(0xFF6C63FF);
  static const Color chatBubbleUserDark = Color(0xFF4A42CC);
  static const Color chatBubbleAiLight = Color(0xFFF0F0F8);
  static const Color chatBubbleAiDark = Color(0xFF2A2A3C);

  static const Color emergencyRed = Color(0xFFE53935);
  static const Color emergencyRedLight = Color(0xFFFFEBEE);
  static const Color emergencyRedDark = Color(0xFF3D1111);

  static const Color streakOrange = Color(0xFFFF9800);
  static const Color badgeGold = Color(0xFFFFD700);
  static const Color successGreen = Color(0xFF4CAF50);

  static const Color compatibilityHigh = Color(0xFF4CAF50);
  static const Color compatibilityMedium = Color(0xFFFFC107);
  static const Color compatibilityLow = Color(0xFFFF5722);
}
