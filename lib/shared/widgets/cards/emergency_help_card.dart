import 'package:flutter/material.dart';

import '../../../core/theme/app_dimensions.dart';
import '../../../core/utils/extensions/context_extensions.dart';

class EmergencyHelpCard extends StatelessWidget {
  const EmergencyHelpCard({
    required this.onTap,
    super.key,
  });

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final ext = context.appColors;

    return Semantics(
      button: true,
      label: 'Get emergency help',
      child: Card(
        color: ext.emergencyBackground,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
          side: BorderSide(color: ext.emergencyRed.withAlpha(77)),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
          child: Padding(
            padding: const EdgeInsets.all(AppDimensions.spacing16),
            child: Row(
              children: [
                Icon(
                  Icons.favorite,
                  color: ext.emergencyRed,
                  size: AppDimensions.iconLarge,
                ),
                const SizedBox(width: AppDimensions.spacing12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Need help now?',
                        style: context.textTheme.titleSmall?.copyWith(
                          color: ext.emergencyRed,
                        ),
                      ),
                      const SizedBox(height: AppDimensions.spacing4),
                      Text(
                        'Tap here for emergency support contacts',
                        style: context.textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: ext.emergencyRed,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
