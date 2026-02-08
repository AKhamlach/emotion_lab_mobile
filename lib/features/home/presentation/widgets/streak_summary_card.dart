import 'package:flutter/material.dart';

import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/utils/extensions/context_extensions.dart';
import '../../../../shared/models/gamification_stats.dart';

class StreakSummaryCard extends StatelessWidget {
  const StreakSummaryCard({
    required this.stats,
    super.key,
  });

  final GamificationStats stats;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.spacing16),
        child: Row(
          children: [
            _StatTile(
              icon: Icons.local_fire_department,
              color: context.appColors.streakOrange,
              value: '${stats.streak}',
              label: 'Day streak',
            ),
            _divider(context),
            _StatTile(
              icon: Icons.star,
              color: context.appColors.badgeGold,
              value: '${stats.points}',
              label: 'Points',
            ),
            _divider(context),
            _StatTile(
              icon: Icons.workspace_premium,
              color: context.colorScheme.primary,
              value: 'Lv ${stats.level}',
              label: '${(stats.levelProgress * 100).round()}% to next',
            ),
          ],
        ),
      ),
    );
  }

  Widget _divider(BuildContext context) {
    return Container(
      width: 1,
      height: 40,
      color: context.colorScheme.outline.withAlpha(51),
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({
    required this.icon,
    required this.color,
    required this.value,
    required this.label,
  });

  final IconData icon;
  final Color color;
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, color: color, size: AppDimensions.iconMedium),
          const SizedBox(height: AppDimensions.spacing4),
          Text(
            value,
            style: context.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppDimensions.spacing4),
          Text(
            label,
            style: context.textTheme.labelSmall?.copyWith(
              color: context.appColors.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
