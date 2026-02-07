import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract final class AppTextStyles {
  static String get _headingFamily => GoogleFonts.nunito().fontFamily!;
  static String get _bodyFamily => GoogleFonts.inter().fontFamily!;

  // ─── Display ───
  static TextStyle get displayLarge => TextStyle(
        fontFamily: _headingFamily,
        fontSize: 57,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.25,
        height: 1.12,
      );

  static TextStyle get displayMedium => TextStyle(
        fontFamily: _headingFamily,
        fontSize: 45,
        fontWeight: FontWeight.w700,
        height: 1.16,
      );

  static TextStyle get displaySmall => TextStyle(
        fontFamily: _headingFamily,
        fontSize: 36,
        fontWeight: FontWeight.w600,
        height: 1.22,
      );

  // ─── Headline ───
  static TextStyle get headlineLarge => TextStyle(
        fontFamily: _headingFamily,
        fontSize: 32,
        fontWeight: FontWeight.w700,
        height: 1.25,
      );

  static TextStyle get headlineMedium => TextStyle(
        fontFamily: _headingFamily,
        fontSize: 28,
        fontWeight: FontWeight.w600,
        height: 1.29,
      );

  static TextStyle get headlineSmall => TextStyle(
        fontFamily: _headingFamily,
        fontSize: 24,
        fontWeight: FontWeight.w600,
        height: 1.33,
      );

  // ─── Title ───
  static TextStyle get titleLarge => TextStyle(
        fontFamily: _headingFamily,
        fontSize: 22,
        fontWeight: FontWeight.w600,
        height: 1.27,
      );

  static TextStyle get titleMedium => TextStyle(
        fontFamily: _bodyFamily,
        fontSize: 16,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.15,
        height: 1.5,
      );

  static TextStyle get titleSmall => TextStyle(
        fontFamily: _bodyFamily,
        fontSize: 14,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.1,
        height: 1.43,
      );

  // ─── Body ───
  static TextStyle get bodyLarge => TextStyle(
        fontFamily: _bodyFamily,
        fontSize: 16,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
        height: 1.5,
      );

  static TextStyle get bodyMedium => TextStyle(
        fontFamily: _bodyFamily,
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
        height: 1.43,
      );

  static TextStyle get bodySmall => TextStyle(
        fontFamily: _bodyFamily,
        fontSize: 12,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
        height: 1.33,
      );

  // ─── Label ───
  static TextStyle get labelLarge => TextStyle(
        fontFamily: _bodyFamily,
        fontSize: 14,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.1,
        height: 1.43,
      );

  static TextStyle get labelMedium => TextStyle(
        fontFamily: _bodyFamily,
        fontSize: 12,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
        height: 1.33,
      );

  static TextStyle get labelSmall => TextStyle(
        fontFamily: _bodyFamily,
        fontSize: 11,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
        height: 1.45,
      );

  /// Builds a complete [TextTheme] using the app's typography.
  static TextTheme get textTheme => TextTheme(
        displayLarge: displayLarge,
        displayMedium: displayMedium,
        displaySmall: displaySmall,
        headlineLarge: headlineLarge,
        headlineMedium: headlineMedium,
        headlineSmall: headlineSmall,
        titleLarge: titleLarge,
        titleMedium: titleMedium,
        titleSmall: titleSmall,
        bodyLarge: bodyLarge,
        bodyMedium: bodyMedium,
        bodySmall: bodySmall,
        labelLarge: labelLarge,
        labelMedium: labelMedium,
        labelSmall: labelSmall,
      );
}
