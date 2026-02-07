import 'package:flutter/material.dart';

import '../../../core/theme/app_dimensions.dart';

class SecondaryButton extends StatelessWidget {
  const SecondaryButton({
    required this.label,
    required this.onPressed,
    this.icon,
    super.key,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: label,
      child: SizedBox(
        width: double.infinity,
        height: AppDimensions.buttonHeight,
        child: OutlinedButton(
          onPressed: onPressed,
          child: icon != null
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
