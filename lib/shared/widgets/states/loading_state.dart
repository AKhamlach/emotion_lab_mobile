import 'package:flutter/material.dart';

import '../../../core/theme/app_dimensions.dart';
import '../../../core/utils/extensions/context_extensions.dart';
import '../indicators/loading_indicator.dart';

class LoadingStateWidget extends StatelessWidget {
  const LoadingStateWidget({
    this.message = 'Loading...',
    super.key,
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.spacing32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const LoadingIndicator(),
            const SizedBox(height: AppDimensions.spacing24),
            Text(
              message,
              style: context.textTheme.bodyMedium?.copyWith(
                color: context.appColors.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
