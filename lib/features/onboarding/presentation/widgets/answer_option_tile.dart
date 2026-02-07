import 'package:flutter/material.dart';

import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/utils/extensions/context_extensions.dart';

class AnswerOptionTile extends StatelessWidget {
  const AnswerOptionTile({
    required this.text,
    required this.isSelected,
    required this.onTap,
    super.key,
  });

  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final primary = context.colorScheme.primary;

    return Semantics(
      selected: isSelected,
      label: text,
      child: Padding(
        padding: const EdgeInsets.only(bottom: AppDimensions.spacing12),
        child: Material(
          color: isSelected ? primary.withAlpha(20) : context.appColors.surfaceVariant,
          borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: AppDimensions.animFast),
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.spacing16,
                vertical: AppDimensions.spacing16,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
                border: Border.all(
                  color: isSelected ? primary : Colors.transparent,
                  width: 2,
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      text,
                      style: context.textTheme.bodyLarge?.copyWith(
                        fontWeight:
                            isSelected ? FontWeight.w600 : FontWeight.w400,
                        color: isSelected
                            ? primary
                            : context.colorScheme.onSurface,
                      ),
                    ),
                  ),
                  AnimatedSwitcher(
                    duration:
                        const Duration(milliseconds: AppDimensions.animFast),
                    child: isSelected
                        ? Icon(Icons.check_circle, color: primary, key: const ValueKey(true))
                        : Icon(Icons.circle_outlined,
                            color: context.appColors.onSurfaceVariant,
                            key: const ValueKey(false)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
