import 'package:flutter/material.dart';

import '../../../../core/theme/app_dimensions.dart';

class OnboardingPageTransition extends StatelessWidget {
  const OnboardingPageTransition({
    required this.child,
    required this.animation,
    super.key,
  });

  final Widget child;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    final slideAnimation = Tween<Offset>(
      begin: const Offset(0.3, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: animation,
      curve: Curves.easeOut,
    ));

    final fadeAnimation = CurvedAnimation(
      parent: animation,
      curve: const Interval(0.0, 0.8, curve: Curves.easeOut),
    );

    return FadeTransition(
      opacity: fadeAnimation,
      child: SlideTransition(
        position: slideAnimation,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.spacing24,
          ),
          child: child,
        ),
      ),
    );
  }
}
