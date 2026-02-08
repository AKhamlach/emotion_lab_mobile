import 'package:flutter/material.dart';

import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/utils/extensions/context_extensions.dart';

class QuickActionsRow extends StatelessWidget {
  const QuickActionsRow({
    required this.onChatTap,
    required this.onBuddyTap,
    required this.onAchievementsTap,
    super.key,
  });

  final VoidCallback onChatTap;
  final VoidCallback onBuddyTap;
  final VoidCallback onAchievementsTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Quick Actions', style: context.textTheme.titleSmall),
        const SizedBox(height: AppDimensions.spacing12),
        Row(
          children: [
            Expanded(
              child: _ActionCard(
                icon: Icons.chat_bubble_outline,
                label: 'Talk to AI',
                onTap: onChatTap,
              ),
            ),
            const SizedBox(width: AppDimensions.spacing12),
            Expanded(
              child: _ActionCard(
                icon: Icons.people_outline,
                label: 'Find Buddy',
                onTap: onBuddyTap,
              ),
            ),
            const SizedBox(width: AppDimensions.spacing12),
            Expanded(
              child: _ActionCard(
                icon: Icons.emoji_events_outlined,
                label: 'Badges',
                onTap: onAchievementsTap,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _ActionCard extends StatelessWidget {
  const _ActionCard({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: label,
      child: Card(
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: AppDimensions.spacing16,
              horizontal: AppDimensions.spacing8,
            ),
            child: Column(
              children: [
                Icon(
                  icon,
                  color: context.colorScheme.primary,
                  size: AppDimensions.iconLarge,
                ),
                const SizedBox(height: AppDimensions.spacing8),
                Text(
                  label,
                  style: context.textTheme.labelMedium,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
