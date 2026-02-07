import 'package:flutter/material.dart';

import '../../../core/theme/app_dimensions.dart';
import '../../../core/utils/extensions/context_extensions.dart';

class EmergencyDialog extends StatelessWidget {
  const EmergencyDialog({
    required this.onContactSupport,
    required this.onDismiss,
    super.key,
  });

  final VoidCallback onContactSupport;
  final VoidCallback onDismiss;

  /// Shows the emergency dialog.
  static Future<void> show(
    BuildContext context, {
    required VoidCallback onContactSupport,
    required VoidCallback onDismiss,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => EmergencyDialog(
        onContactSupport: onContactSupport,
        onDismiss: onDismiss,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ext = context.appColors;

    return AlertDialog(
      icon: Icon(
        Icons.favorite,
        color: ext.emergencyRed,
        size: AppDimensions.iconXLarge,
      ),
      title: const Text("We're here for you"),
      content: const Text(
        'It sounds like you might be going through a tough time. '
        'Would you like to see emergency support resources?',
      ),
      actions: [
        TextButton(
          onPressed: onDismiss,
          child: const Text("I'm okay"),
        ),
        const SizedBox(width: AppDimensions.spacing8),
        ElevatedButton(
          onPressed: onContactSupport,
          style: ElevatedButton.styleFrom(
            backgroundColor: ext.emergencyRed,
            foregroundColor: Colors.white,
          ),
          child: const Text('Get help'),
        ),
      ],
    );
  }
}
