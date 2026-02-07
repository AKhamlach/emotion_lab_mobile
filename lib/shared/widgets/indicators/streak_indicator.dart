import 'package:flutter/material.dart';

import '../../../core/theme/app_dimensions.dart';
import '../../../core/utils/extensions/context_extensions.dart';

class StreakIndicator extends StatelessWidget {
  const StreakIndicator({
    required this.streakCount,
    super.key,
  });

  final int streakCount;

  @override
  Widget build(BuildContext context) {
    final color = context.appColors.streakOrange;

    return Semantics(
      label: '$streakCount day streak',
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.local_fire_department,
            color: color,
            size: AppDimensions.iconMedium,
          ),
          const SizedBox(width: AppDimensions.spacing4),
          Text(
            '$streakCount',
            style: context.textTheme.titleMedium?.copyWith(
              color: color,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
