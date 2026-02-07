import 'package:flutter/material.dart';

import '../../../core/theme/app_dimensions.dart';

class ResponsiveBuilder extends StatelessWidget {
  const ResponsiveBuilder({
    required this.builder,
    super.key,
  });

  final Widget Function(
    BuildContext context,
    BoxConstraints constraints,
    ResponsiveSize size,
  ) builder;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = ResponsiveSize.fromWidth(constraints.maxWidth);
        return builder(context, constraints, size);
      },
    );
  }
}

enum ResponsiveSize {
  small,
  medium,
  large;

  factory ResponsiveSize.fromWidth(double width) {
    if (width < 360) return ResponsiveSize.small;
    if (width < AppDimensions.maxContentWidth) return ResponsiveSize.medium;
    return ResponsiveSize.large;
  }

  bool get isSmall => this == small;
  bool get isMedium => this == medium;
  bool get isLarge => this == large;
}
