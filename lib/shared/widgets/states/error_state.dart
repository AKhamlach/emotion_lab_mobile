import 'package:flutter/material.dart';

import '../../../core/theme/app_dimensions.dart';
import '../../../core/utils/extensions/context_extensions.dart';

class ErrorStateWidget extends StatelessWidget {
  const ErrorStateWidget({
    required this.message,
    this.onRetry,
    super.key,
  });

  final String message;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.spacing32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline,
              size: AppDimensions.iconXLarge * 1.5,
              color: context.colorScheme.error,
            ),
            const SizedBox(height: AppDimensions.spacing16),
            Text(
              message,
              style: context.textTheme.bodyLarge?.copyWith(
                color: context.appColors.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            if (onRetry != null) ...[
              const SizedBox(height: AppDimensions.spacing24),
              TextButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: const Text('Try again'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
