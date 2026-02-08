import 'package:flutter/material.dart';

import '../../../../core/theme/app_dimensions.dart';

class QuickRepliesRow extends StatelessWidget {
  const QuickRepliesRow({
    required this.onReplySelected,
    super.key,
  });

  final ValueChanged<String> onReplySelected;

  static const _quickReplies = [
    'How are you?',
    "I'm feeling stressed",
    'Tell me something positive',
    'I need advice',
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.spacing16,
        ),
        itemCount: _quickReplies.length,
        separatorBuilder: (_, _) =>
            const SizedBox(width: AppDimensions.spacing8),
        itemBuilder: (context, index) {
          final reply = _quickReplies[index];
          return ActionChip(
            label: Text(reply),
            labelStyle: theme.textTheme.labelMedium,
            onPressed: () => onReplySelected(reply),
          );
        },
      ),
    );
  }
}
