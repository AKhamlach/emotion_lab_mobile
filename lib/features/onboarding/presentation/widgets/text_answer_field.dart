import 'package:flutter/material.dart';

import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/utils/extensions/context_extensions.dart';

class TextAnswerField extends StatelessWidget {
  const TextAnswerField({
    required this.controller,
    this.hintText = 'Type your answer...',
    this.maxLength = 200,
    super.key,
  });

  final TextEditingController controller;
  final String hintText;
  final int maxLength;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: AppDimensions.spacing16),
      child: TextField(
        controller: controller,
        maxLength: maxLength,
        maxLines: 4,
        minLines: 2,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          hintText: hintText,
          counterStyle: context.textTheme.bodySmall?.copyWith(
            color: context.appColors.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}
