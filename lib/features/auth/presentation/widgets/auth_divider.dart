import 'package:flutter/material.dart';

import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/utils/extensions/context_extensions.dart';

class AuthDivider extends StatelessWidget {
  const AuthDivider({super.key});

  @override
  Widget build(BuildContext context) {
    final dividerColor = context.colorScheme.outline;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppDimensions.spacing24),
      child: Row(
        children: [
          Expanded(child: Divider(color: dividerColor)),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.spacing16,
            ),
            child: Text(
              'OR',
              style: context.textTheme.labelMedium?.copyWith(
                color: context.appColors.onSurfaceVariant,
              ),
            ),
          ),
          Expanded(child: Divider(color: dividerColor)),
        ],
      ),
    );
  }
}
