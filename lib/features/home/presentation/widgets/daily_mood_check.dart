import 'package:flutter/material.dart';

import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/utils/extensions/context_extensions.dart';

class DailyMoodCheck extends StatelessWidget {
  const DailyMoodCheck({
    required this.onMoodSelected,
    this.selectedMood,
    super.key,
  });

  final String? selectedMood;
  final ValueChanged<String> onMoodSelected;

  static const _moods = [
    ('Great', Icons.sentiment_very_satisfied),
    ('Good', Icons.sentiment_satisfied),
    ('Okay', Icons.sentiment_neutral),
    ('Low', Icons.sentiment_dissatisfied),
    ('Bad', Icons.sentiment_very_dissatisfied),
  ];

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.spacing16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              selectedMood != null
                  ? "You're feeling $selectedMood today"
                  : 'How are you feeling today?',
              style: context.textTheme.titleSmall,
            ),
            const SizedBox(height: AppDimensions.spacing12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: _moods.map((mood) {
                final isSelected = selectedMood == mood.$1;
                return _MoodButton(
                  label: mood.$1,
                  icon: mood.$2,
                  isSelected: isSelected,
                  onTap: () => onMoodSelected(mood.$1),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class _MoodButton extends StatelessWidget {
  const _MoodButton({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = isSelected
        ? context.colorScheme.primary
        : context.appColors.onSurfaceVariant;

    return Semantics(
      label: 'Feeling $label',
      selected: isSelected,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.spacing8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: color, size: AppDimensions.iconLarge),
              const SizedBox(height: AppDimensions.spacing4),
              Text(
                label,
                style: context.textTheme.labelSmall?.copyWith(
                  color: color,
                  fontWeight:
                      isSelected ? FontWeight.w700 : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
