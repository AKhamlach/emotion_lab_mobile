import 'package:flutter/material.dart';

import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/utils/extensions/context_extensions.dart';

class ProgressDots extends StatelessWidget {
  const ProgressDots({
    required this.total,
    required this.current,
    super.key,
  });

  final int total;
  final int current;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Question ${current + 1} of $total',
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(total, (index) {
          final isActive = index == current;
          final isCompleted = index < current;

          return AnimatedContainer(
            duration: const Duration(milliseconds: AppDimensions.animFast),
            margin: const EdgeInsets.symmetric(
              horizontal: 3,
            ),
            width: isActive ? 24 : 8,
            height: 8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppDimensions.radiusCircular),
              color: isActive
                  ? context.colorScheme.primary
                  : isCompleted
                      ? context.colorScheme.primary.withAlpha(102)
                      : context.appColors.surfaceVariant,
            ),
          );
        }),
      ),
    );
  }
}
