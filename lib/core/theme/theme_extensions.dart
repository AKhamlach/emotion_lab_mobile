import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppThemeExtension extends ThemeExtension<AppThemeExtension> {
  const AppThemeExtension({
    required this.chatBubbleUser,
    required this.chatBubbleAi,
    required this.onChatBubbleUser,
    required this.onChatBubbleAi,
    required this.emergencyRed,
    required this.emergencyBackground,
    required this.streakOrange,
    required this.badgeGold,
    required this.successGreen,
    required this.compatibilityHigh,
    required this.compatibilityMedium,
    required this.compatibilityLow,
    required this.surfaceVariant,
    required this.onSurfaceVariant,
  });

  final Color chatBubbleUser;
  final Color chatBubbleAi;
  final Color onChatBubbleUser;
  final Color onChatBubbleAi;
  final Color emergencyRed;
  final Color emergencyBackground;
  final Color streakOrange;
  final Color badgeGold;
  final Color successGreen;
  final Color compatibilityHigh;
  final Color compatibilityMedium;
  final Color compatibilityLow;
  final Color surfaceVariant;
  final Color onSurfaceVariant;

  static const light = AppThemeExtension(
    chatBubbleUser: AppColors.chatBubbleUserLight,
    chatBubbleAi: AppColors.chatBubbleAiLight,
    onChatBubbleUser: Colors.white,
    onChatBubbleAi: AppColors.onSurfaceLight,
    emergencyRed: AppColors.emergencyRed,
    emergencyBackground: AppColors.emergencyRedLight,
    streakOrange: AppColors.streakOrange,
    badgeGold: AppColors.badgeGold,
    successGreen: AppColors.successGreen,
    compatibilityHigh: AppColors.compatibilityHigh,
    compatibilityMedium: AppColors.compatibilityMedium,
    compatibilityLow: AppColors.compatibilityLow,
    surfaceVariant: AppColors.surfaceVariantLight,
    onSurfaceVariant: AppColors.onSurfaceVariantLight,
  );

  static const dark = AppThemeExtension(
    chatBubbleUser: AppColors.chatBubbleUserDark,
    chatBubbleAi: AppColors.chatBubbleAiDark,
    onChatBubbleUser: Colors.white,
    onChatBubbleAi: AppColors.onSurfaceDark,
    emergencyRed: AppColors.emergencyRed,
    emergencyBackground: AppColors.emergencyRedDark,
    streakOrange: AppColors.streakOrange,
    badgeGold: AppColors.badgeGold,
    successGreen: AppColors.successGreen,
    compatibilityHigh: AppColors.compatibilityHigh,
    compatibilityMedium: AppColors.compatibilityMedium,
    compatibilityLow: AppColors.compatibilityLow,
    surfaceVariant: AppColors.surfaceVariantDark,
    onSurfaceVariant: AppColors.onSurfaceVariantDark,
  );

  @override
  AppThemeExtension copyWith({
    Color? chatBubbleUser,
    Color? chatBubbleAi,
    Color? onChatBubbleUser,
    Color? onChatBubbleAi,
    Color? emergencyRed,
    Color? emergencyBackground,
    Color? streakOrange,
    Color? badgeGold,
    Color? successGreen,
    Color? compatibilityHigh,
    Color? compatibilityMedium,
    Color? compatibilityLow,
    Color? surfaceVariant,
    Color? onSurfaceVariant,
  }) {
    return AppThemeExtension(
      chatBubbleUser: chatBubbleUser ?? this.chatBubbleUser,
      chatBubbleAi: chatBubbleAi ?? this.chatBubbleAi,
      onChatBubbleUser: onChatBubbleUser ?? this.onChatBubbleUser,
      onChatBubbleAi: onChatBubbleAi ?? this.onChatBubbleAi,
      emergencyRed: emergencyRed ?? this.emergencyRed,
      emergencyBackground: emergencyBackground ?? this.emergencyBackground,
      streakOrange: streakOrange ?? this.streakOrange,
      badgeGold: badgeGold ?? this.badgeGold,
      successGreen: successGreen ?? this.successGreen,
      compatibilityHigh: compatibilityHigh ?? this.compatibilityHigh,
      compatibilityMedium: compatibilityMedium ?? this.compatibilityMedium,
      compatibilityLow: compatibilityLow ?? this.compatibilityLow,
      surfaceVariant: surfaceVariant ?? this.surfaceVariant,
      onSurfaceVariant: onSurfaceVariant ?? this.onSurfaceVariant,
    );
  }

  @override
  AppThemeExtension lerp(covariant AppThemeExtension? other, double t) {
    if (other is! AppThemeExtension) return this;
    return AppThemeExtension(
      chatBubbleUser: Color.lerp(chatBubbleUser, other.chatBubbleUser, t)!,
      chatBubbleAi: Color.lerp(chatBubbleAi, other.chatBubbleAi, t)!,
      onChatBubbleUser:
          Color.lerp(onChatBubbleUser, other.onChatBubbleUser, t)!,
      onChatBubbleAi: Color.lerp(onChatBubbleAi, other.onChatBubbleAi, t)!,
      emergencyRed: Color.lerp(emergencyRed, other.emergencyRed, t)!,
      emergencyBackground:
          Color.lerp(emergencyBackground, other.emergencyBackground, t)!,
      streakOrange: Color.lerp(streakOrange, other.streakOrange, t)!,
      badgeGold: Color.lerp(badgeGold, other.badgeGold, t)!,
      successGreen: Color.lerp(successGreen, other.successGreen, t)!,
      compatibilityHigh:
          Color.lerp(compatibilityHigh, other.compatibilityHigh, t)!,
      compatibilityMedium:
          Color.lerp(compatibilityMedium, other.compatibilityMedium, t)!,
      compatibilityLow:
          Color.lerp(compatibilityLow, other.compatibilityLow, t)!,
      surfaceVariant: Color.lerp(surfaceVariant, other.surfaceVariant, t)!,
      onSurfaceVariant:
          Color.lerp(onSurfaceVariant, other.onSurfaceVariant, t)!,
    );
  }
}
