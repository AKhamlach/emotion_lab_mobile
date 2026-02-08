import 'package:flutter/material.dart';

import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/utils/extensions/context_extensions.dart';

class GreetingHeader extends StatelessWidget {
  const GreetingHeader({
    required this.pseudonym,
    super.key,
  });

  final String pseudonym;

  String get _greeting {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good morning';
    if (hour < 17) return 'Good afternoon';
    return 'Good evening';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$_greeting,',
          style: context.textTheme.titleMedium?.copyWith(
            color: context.appColors.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: AppDimensions.spacing4),
        Text(
          pseudonym,
          style: context.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
