import 'package:flutter/material.dart';

import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/utils/extensions/context_extensions.dart';

class SocialLoginButtons extends StatelessWidget {
  const SocialLoginButtons({
    this.onGoogleTap,
    this.onAppleTap,
    super.key,
  });

  final VoidCallback? onGoogleTap;
  final VoidCallback? onAppleTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _SocialButton(
          label: 'Continue with Google',
          icon: Icons.g_mobiledata,
          onTap: onGoogleTap,
        ),
        const SizedBox(height: AppDimensions.spacing12),
        _SocialButton(
          label: 'Continue with Apple',
          icon: Icons.apple,
          onTap: onAppleTap,
        ),
      ],
    );
  }
}

class _SocialButton extends StatelessWidget {
  const _SocialButton({
    required this.label,
    required this.icon,
    this.onTap,
  });

  final String label;
  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: label,
      child: SizedBox(
        width: double.infinity,
        height: AppDimensions.buttonHeight,
        child: OutlinedButton.icon(
          onPressed: onTap,
          icon: Icon(icon, size: AppDimensions.iconMedium),
          label: Text(label),
          style: OutlinedButton.styleFrom(
            foregroundColor: context.colorScheme.onSurface,
            side: BorderSide(color: context.colorScheme.outline),
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(AppDimensions.radiusMedium),
            ),
          ),
        ),
      ),
    );
  }
}
