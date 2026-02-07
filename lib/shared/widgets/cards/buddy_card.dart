import 'package:flutter/material.dart';

import '../../../core/theme/app_dimensions.dart';
import '../../../core/utils/extensions/context_extensions.dart';

class BuddyCard extends StatelessWidget {
  const BuddyCard({
    required this.pseudonym,
    required this.compatibilityScore,
    required this.sharedTraits,
    this.onTap,
    super.key,
  });

  final String pseudonym;
  final double compatibilityScore;
  final List<String> sharedTraits;
  final VoidCallback? onTap;

  Color _compatibilityColor(BuildContext context) {
    final ext = context.appColors;
    if (compatibilityScore >= 0.7) return ext.compatibilityHigh;
    if (compatibilityScore >= 0.4) return ext.compatibilityMedium;
    return ext.compatibilityLow;
  }

  @override
  Widget build(BuildContext context) {
    final compatColor = _compatibilityColor(context);
    final percent = (compatibilityScore * 100).round();

    return Semantics(
      label: '$pseudonym, $percent% compatible',
      child: Card(
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
          child: Padding(
            padding: const EdgeInsets.all(AppDimensions.spacing16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: AppDimensions.avatarSmall / 2,
                      backgroundColor:
                          context.colorScheme.primary.withAlpha(31),
                      child: Text(
                        pseudonym.isNotEmpty ? pseudonym[0].toUpperCase() : '?',
                        style: context.textTheme.titleMedium?.copyWith(
                          color: context.colorScheme.primary,
                        ),
                      ),
                    ),
                    const SizedBox(width: AppDimensions.spacing12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            pseudonym,
                            style: context.textTheme.titleSmall,
                          ),
                          const SizedBox(height: AppDimensions.spacing4),
                          Text(
                            '$percent% compatible',
                            style: context.textTheme.bodySmall?.copyWith(
                              color: compatColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppDimensions.spacing12),
                // Compatibility bar
                ClipRRect(
                  borderRadius:
                      BorderRadius.circular(AppDimensions.radiusSmall),
                  child: LinearProgressIndicator(
                    value: compatibilityScore,
                    backgroundColor: compatColor.withAlpha(31),
                    color: compatColor,
                    minHeight: 6,
                  ),
                ),
                if (sharedTraits.isNotEmpty) ...[
                  const SizedBox(height: AppDimensions.spacing12),
                  Wrap(
                    spacing: AppDimensions.spacing8,
                    runSpacing: AppDimensions.spacing4,
                    children: sharedTraits
                        .map(
                          (trait) => Chip(
                            label: Text(
                              trait,
                              style: context.textTheme.labelSmall,
                            ),
                            visualDensity: VisualDensity.compact,
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                          ),
                        )
                        .toList(),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
