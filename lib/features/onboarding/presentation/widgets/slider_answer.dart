import 'package:flutter/material.dart';

import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/utils/extensions/context_extensions.dart';

class SliderAnswer extends StatelessWidget {
  const SliderAnswer({
    required this.value,
    required this.onChanged,
    this.min = 1,
    this.max = 5,
    this.minLabel,
    this.maxLabel,
    super.key,
  });

  final double value;
  final ValueChanged<double> onChanged;
  final double min;
  final double max;
  final String? minLabel;
  final String? maxLabel;

  @override
  Widget build(BuildContext context) {
    final divisions = (max - min).round();

    return Column(
      children: [
        const SizedBox(height: AppDimensions.spacing24),
        // Current value display
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: context.colorScheme.primary.withAlpha(20),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              value.round().toString(),
              style: context.textTheme.headlineSmall?.copyWith(
                color: context.colorScheme.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        const SizedBox(height: AppDimensions.spacing24),
        Slider(
          value: value,
          min: min,
          max: max,
          divisions: divisions,
          label: value.round().toString(),
          onChanged: onChanged,
        ),
        if (minLabel != null || maxLabel != null)
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.spacing8,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  minLabel ?? '',
                  style: context.textTheme.bodySmall?.copyWith(
                    color: context.appColors.onSurfaceVariant,
                  ),
                ),
                Text(
                  maxLabel ?? '',
                  style: context.textTheme.bodySmall?.copyWith(
                    color: context.appColors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
