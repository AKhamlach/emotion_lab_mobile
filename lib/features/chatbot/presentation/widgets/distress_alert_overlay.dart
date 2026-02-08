import 'package:flutter/material.dart';

import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/utils/extensions/context_extensions.dart';

class DistressAlertOverlay extends StatelessWidget {
  const DistressAlertOverlay({
    required this.onDismiss,
    required this.onEmergencyTap,
    super.key,
  });

  final VoidCallback onDismiss;
  final VoidCallback onEmergencyTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Container(
      margin: const EdgeInsets.all(AppDimensions.spacing16),
      padding: const EdgeInsets.all(AppDimensions.spacing16),
      decoration: BoxDecoration(
        color: colors.emergencyBackground,
        borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
        border: Border.all(color: colors.emergencyRed),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Icon(
                Icons.favorite_rounded,
                color: colors.emergencyRed,
              ),
              const SizedBox(width: AppDimensions.spacing8),
              Expanded(
                child: Text(
                  "We're here for you",
                  style: context.textTheme.titleSmall?.copyWith(
                    color: colors.emergencyRed,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close, size: AppDimensions.iconSmall),
                onPressed: onDismiss,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
          const SizedBox(height: AppDimensions.spacing8),
          Text(
            'It sounds like you might be going through a tough time. '
            'Professional support is available and can help.',
            style: context.textTheme.bodySmall,
          ),
          const SizedBox(height: AppDimensions.spacing12),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: onEmergencyTap,
              icon: const Icon(Icons.phone_rounded),
              label: const Text('View Support Resources'),
              style: FilledButton.styleFrom(
                backgroundColor: colors.emergencyRed,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
