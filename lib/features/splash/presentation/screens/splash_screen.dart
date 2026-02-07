import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/route_names.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/utils/extensions/context_extensions.dart';
import '../../../../shared/widgets/animations/fade_slide_transition.dart';
import '../../../auth/bloc/auth_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuthAfterDelay();
  }

  Future<void> _checkAuthAfterDelay() async {
    await Future.delayed(
      const Duration(milliseconds: AppDimensions.splashDuration),
    );
    if (!mounted) return;
    context.read<AuthBloc>().add(const AuthCheckRequested());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Authenticated) {
          context.goNamed(RouteNames.home);
        } else if (state is Unauthenticated) {
          context.goNamed(RouteNames.login);
        }
      },
      child: Scaffold(
        body: Center(
          child: FadeSlideTransition(
            duration: const Duration(milliseconds: AppDimensions.animSlow),
            offset: const Offset(0, 30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Logo placeholder
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: context.colorScheme.primary.withAlpha(31),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.psychology_alt,
                    size: 56,
                    color: context.colorScheme.primary,
                  ),
                ),
                const SizedBox(height: AppDimensions.spacing24),
                Text(
                  'Emotion Lab',
                  style: context.textTheme.headlineLarge?.copyWith(
                    color: context.colorScheme.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: AppDimensions.spacing8),
                Text(
                  'Your space to grow',
                  style: context.textTheme.bodyLarge?.copyWith(
                    color: context.appColors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
