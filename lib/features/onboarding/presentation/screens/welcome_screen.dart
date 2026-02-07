import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/route_names.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/utils/extensions/context_extensions.dart';
import '../../../../shared/widgets/animations/fade_slide_transition.dart';
import '../../../../shared/widgets/buttons/primary_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.spacing24,
          ),
          child: Column(
            children: [
              const Spacer(),
              FadeSlideTransition(
                offset: const Offset(0, 30),
                child: Column(
                  children: [
                    // Illustration placeholder
                    Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        color: context.colorScheme.primary.withAlpha(20),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.self_improvement,
                        size: 100,
                        color: context.colorScheme.primary.withAlpha(153),
                      ),
                    ),
                    const SizedBox(height: AppDimensions.spacing32),
                    Text(
                      "Let's get to know you",
                      style: context.textTheme.headlineMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppDimensions.spacing12),
                    Text(
                      "We'll ask a few quick questions to personalize your "
                      'experience. This helps us match you with the right '
                      'support and companions.',
                      style: context.textTheme.bodyLarge?.copyWith(
                        color: context.appColors.onSurfaceVariant,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const Spacer(),
              FadeSlideTransition(
                delay: const Duration(milliseconds: AppDimensions.animNormal),
                child: Column(
                  children: [
                    PrimaryButton(
                      label: 'Get Started',
                      onPressed: () => context.goNamed(RouteNames.onboarding),
                    ),
                    const SizedBox(height: AppDimensions.spacing12),
                    Text(
                      'Takes about 3 minutes',
                      style: context.textTheme.bodySmall?.copyWith(
                        color: context.appColors.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: AppDimensions.spacing32),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
