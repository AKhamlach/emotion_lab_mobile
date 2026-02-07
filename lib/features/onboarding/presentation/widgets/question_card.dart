import 'package:flutter/material.dart';

import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/utils/extensions/context_extensions.dart';
import '../../../../shared/models/psychometric_question.dart';

class QuestionCard extends StatelessWidget {
  const QuestionCard({
    required this.question,
    super.key,
  });

  final PsychometricQuestion question;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Category label
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.spacing12,
            vertical: AppDimensions.spacing4,
          ),
          decoration: BoxDecoration(
            color: context.colorScheme.primary.withAlpha(20),
            borderRadius: BorderRadius.circular(AppDimensions.radiusCircular),
          ),
          child: Text(
            question.categoryLabel,
            style: context.textTheme.labelSmall?.copyWith(
              color: context.colorScheme.primary,
            ),
          ),
        ),
        const SizedBox(height: AppDimensions.spacing16),
        // Emoji + question text
        if (question.emoji != null) ...[
          Text(
            question.emoji!,
            style: const TextStyle(fontSize: 40),
          ),
          const SizedBox(height: AppDimensions.spacing12),
        ],
        Text(
          question.text,
          style: context.textTheme.headlineSmall,
        ),
      ],
    );
  }
}
