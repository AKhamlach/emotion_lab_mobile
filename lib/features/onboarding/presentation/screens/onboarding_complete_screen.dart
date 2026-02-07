import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/route_names.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/utils/extensions/context_extensions.dart';
import '../../../../shared/widgets/animations/celebration_animation.dart';
import '../../../../shared/widgets/animations/fade_slide_transition.dart';
import '../../../../shared/widgets/buttons/primary_button.dart';
import '../../../auth/bloc/auth_bloc.dart';

class OnboardingCompleteScreen extends StatelessWidget {
  const OnboardingCompleteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authState = context.watch<AuthBloc>().state;
    final pseudonym = authState is Authenticated
        ? authState.user.pseudonym
        : 'Explorer';

    return Scaffold(
      body: Stack(
        children: [
          // Confetti layer
          const Positioned.fill(
            child: IgnorePointer(
              child: CelebrationAnimation(),
            ),
          ),
          // Content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.spacing24,
              ),
              child: Column(
                children: [
                  const Spacer(),
                  FadeSlideTransition(
                    delay: const Duration(
                      milliseconds: AppDimensions.animNormal,
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            color: context.appColors.successGreen.withAlpha(31),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.check_circle,
                            size: 72,
                            color: context.appColors.successGreen,
                          ),
                        ),
                        const SizedBox(height: AppDimensions.spacing32),
                        Text(
                          "You're all set!",
                          style: context.textTheme.headlineMedium,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: AppDimensions.spacing12),
                        Text(
                          'Your profile has been created. '
                          "From now on, you'll be known as",
                          style: context.textTheme.bodyLarge?.copyWith(
                            color: context.appColors.onSurfaceVariant,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: AppDimensions.spacing16),
                        // Pseudonym reveal
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppDimensions.spacing24,
                            vertical: AppDimensions.spacing12,
                          ),
                          decoration: BoxDecoration(
                            color: context.colorScheme.primary.withAlpha(20),
                            borderRadius: BorderRadius.circular(
                              AppDimensions.radiusCircular,
                            ),
                          ),
                          child: Text(
                            pseudonym,
                            style: context.textTheme.titleLarge?.copyWith(
                              color: context.colorScheme.primary,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  FadeSlideTransition(
                    delay: const Duration(milliseconds: AppDimensions.animSlow),
                    child: Column(
                      children: [
                        PrimaryButton(
                          label: 'Enter Emotion Lab',
                          onPressed: () => context.goNamed(RouteNames.home),
                        ),
                        const SizedBox(height: AppDimensions.spacing32),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
