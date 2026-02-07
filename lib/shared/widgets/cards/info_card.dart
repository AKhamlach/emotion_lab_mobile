import 'package:flutter/material.dart';

import '../../../core/theme/app_dimensions.dart';
import '../../../core/utils/extensions/context_extensions.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({
    required this.title,
    required this.subtitle,
    this.icon,
    this.onTap,
    super.key,
  });

  final String title;
  final String subtitle;
  final IconData? icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: title,
      child: Card(
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
          child: Padding(
            padding: const EdgeInsets.all(AppDimensions.spacing16),
            child: Row(
              children: [
                if (icon != null) ...[
                  Icon(
                    icon,
                    color: context.colorScheme.primary,
                    size: AppDimensions.iconLarge,
                  ),
                  const SizedBox(width: AppDimensions.spacing12),
                ],
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: context.textTheme.titleSmall),
                      const SizedBox(height: AppDimensions.spacing4),
                      Text(
                        subtitle,
                        style: context.textTheme.bodySmall?.copyWith(
                          color: context.appColors.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                if (onTap != null)
                  Icon(
                    Icons.chevron_right,
                    color: context.appColors.onSurfaceVariant,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
