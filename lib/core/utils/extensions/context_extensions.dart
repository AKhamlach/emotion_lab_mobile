import 'package:flutter/material.dart';

import '../../theme/theme_extensions.dart';

extension BuildContextX on BuildContext {
  // ─── Theme shortcuts ───
  ThemeData get theme => Theme.of(this);
  ColorScheme get colorScheme => theme.colorScheme;
  TextTheme get textTheme => theme.textTheme;
  AppThemeExtension get appColors =>
      theme.extension<AppThemeExtension>() ?? AppThemeExtension.light;

  // ─── MediaQuery shortcuts ───
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  Size get screenSize => mediaQuery.size;
  double get screenWidth => screenSize.width;
  double get screenHeight => screenSize.height;
  EdgeInsets get viewPadding => mediaQuery.viewPadding;
  EdgeInsets get viewInsets => mediaQuery.viewInsets;
  bool get isKeyboardOpen => viewInsets.bottom > 0;

  // ─── Brightness ───
  bool get isDarkMode => theme.brightness == Brightness.dark;

  // ─── Responsive breakpoints ───
  bool get isSmallScreen => screenWidth < 360;
  bool get isMediumScreen => screenWidth >= 360 && screenWidth < 600;
  bool get isLargeScreen => screenWidth >= 600;

  // ─── Navigation ───
  void popIfCan() {
    if (Navigator.of(this).canPop()) {
      Navigator.of(this).pop();
    }
  }

  // ─── Snackbar ───
  void showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(this)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor:
              isError ? colorScheme.error : colorScheme.inverseSurface,
        ),
      );
  }
}
