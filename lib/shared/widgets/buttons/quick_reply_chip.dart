import 'package:flutter/material.dart';

import '../../../core/theme/app_dimensions.dart';

class QuickReplyChip extends StatelessWidget {
  const QuickReplyChip({
    required this.label,
    required this.onTap,
    super.key,
  });

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: label,
      child: ActionChip(
        label: Text(label),
        onPressed: onTap,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.spacing12,
          vertical: AppDimensions.spacing4,
        ),
      ),
    );
  }
}
