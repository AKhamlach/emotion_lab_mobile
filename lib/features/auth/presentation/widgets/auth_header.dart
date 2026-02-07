import 'package:flutter/material.dart';

import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/utils/extensions/context_extensions.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader({
    required this.title,
    required this.subtitle,
    super.key,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: AppDimensions.spacing32),
        // Logo placeholder
        Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            color: context.colorScheme.primary.withAlpha(31),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.psychology_alt,
            size: 40,
            color: context.colorScheme.primary,
          ),
        ),
        const SizedBox(height: AppDimensions.spacing24),
        Text(
          title,
          style: context.textTheme.headlineSmall,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppDimensions.spacing8),
        Text(
          subtitle,
          style: context.textTheme.bodyMedium?.copyWith(
            color: context.appColors.onSurfaceVariant,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppDimensions.spacing32),
      ],
    );
  }
}
