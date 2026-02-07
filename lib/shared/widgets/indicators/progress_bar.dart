import 'package:flutter/material.dart';

import '../../../core/theme/app_dimensions.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({
    required this.progress,
    this.height = 6,
    this.backgroundColor,
    this.foregroundColor,
    super.key,
  });

  /// Value between 0.0 and 1.0.
  final double progress;
  final double height;
  final Color? backgroundColor;
  final Color? foregroundColor;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Semantics(
      label: '${(progress * 100).round()}% complete',
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
        child: LinearProgressIndicator(
          value: progress.clamp(0.0, 1.0),
          minHeight: height,
          backgroundColor:
              backgroundColor ?? colorScheme.primary.withAlpha(31),
          color: foregroundColor ?? colorScheme.primary,
        ),
      ),
    );
  }
}
