import 'package:flutter/material.dart';

import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/utils/extensions/context_extensions.dart';

class ChatDisclaimerBanner extends StatelessWidget {
  const ChatDisclaimerBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.spacing16,
        vertical: AppDimensions.spacing8,
      ),
      color: context.appColors.surfaceVariant,
      child: Text(
        'This is an AI companion, not a licensed therapist. '
        'If you are in crisis, please use the emergency resources.',
        style: context.textTheme.bodySmall?.copyWith(
          color: context.appColors.onSurfaceVariant,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
