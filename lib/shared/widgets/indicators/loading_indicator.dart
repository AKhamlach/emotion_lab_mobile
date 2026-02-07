import 'package:flutter/material.dart';

import '../../../core/theme/app_dimensions.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({
    this.size = AppDimensions.iconLarge,
    this.strokeWidth = 3,
    this.color,
    super.key,
  });

  final double size;
  final double strokeWidth;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Loading',
      child: SizedBox(
        width: size,
        height: size,
        child: CircularProgressIndicator(
          strokeWidth: strokeWidth,
          color: color ?? Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}
