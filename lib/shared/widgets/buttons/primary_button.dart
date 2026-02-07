import 'package:flutter/material.dart';

import '../../../core/theme/app_dimensions.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.icon,
    super.key,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: label,
      child: SizedBox(
        width: double.infinity,
        height: AppDimensions.buttonHeight,
        child: ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          child: isLoading
              ? SizedBox(
                  height: AppDimensions.iconMedium,
                  width: AppDimensions.iconMedium,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                )
              : icon != null
                  ? Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(icon, size: AppDimensions.iconMedium),
                        const SizedBox(width: AppDimensions.spacing8),
                        Text(label),
                      ],
                    )
                  : Text(label),
        ),
      ),
    );
  }
}
