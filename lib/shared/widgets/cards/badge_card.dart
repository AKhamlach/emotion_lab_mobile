import 'package:flutter/material.dart';

import '../../../core/theme/app_dimensions.dart';
import '../../../core/utils/extensions/context_extensions.dart';

class BadgeCard extends StatelessWidget {
  const BadgeCard({
    required this.name,
    required this.icon,
    required this.isEarned,
    this.onTap,
    super.key,
  });

  final String name;
  final IconData icon;
  final bool isEarned;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final earnedColor = context.appColors.badgeGold;
    final lockedColor = context.appColors.onSurfaceVariant;

    return Semantics(
      label: '$name badge, ${isEarned ? 'earned' : 'locked'}',
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: AppDimensions.badgeSize,
              height: AppDimensions.badgeSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isEarned
                    ? earnedColor.withAlpha(31)
                    : context.appColors.surfaceVariant,
                border: Border.all(
                  color: isEarned ? earnedColor : lockedColor.withAlpha(77),
                  width: 2,
                ),
              ),
              child: Icon(
                isEarned ? icon : Icons.lock_outline,
                color: isEarned ? earnedColor : lockedColor,
                size: AppDimensions.iconLarge,
              ),
            ),
            const SizedBox(height: AppDimensions.spacing8),
            Text(
              name,
              style: context.textTheme.labelSmall?.copyWith(
                color: isEarned
                    ? context.colorScheme.onSurface
                    : lockedColor,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
