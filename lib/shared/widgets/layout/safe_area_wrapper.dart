import 'package:flutter/material.dart';

import '../../../core/theme/app_dimensions.dart';

class SafeAreaWrapper extends StatelessWidget {
  const SafeAreaWrapper({
    required this.child,
    this.top = true,
    this.bottom = true,
    this.horizontalPadding = AppDimensions.spacing16,
    super.key,
  });

  final Widget child;
  final bool top;
  final bool bottom;
  final double horizontalPadding;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: top,
      bottom: bottom,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        child: child,
      ),
    );
  }
}
