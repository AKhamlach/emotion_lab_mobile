import 'package:flutter/material.dart';

import '../core/theme/app_theme.dart';
import '../features/auth/bloc/auth_bloc.dart';
import '../features/onboarding/bloc/onboarding_bloc.dart';
import 'router/app_router.dart';

class EmotionLabApp extends StatefulWidget {
  const EmotionLabApp({
    super.key,
    required this.authBloc,
    required this.onboardingBloc,
  });

  final AuthBloc authBloc;
  final OnboardingBloc onboardingBloc;

  @override
  State<EmotionLabApp> createState() => _EmotionLabAppState();
}

class _EmotionLabAppState extends State<EmotionLabApp> {
  late final AppRouter _appRouter;

  @override
  void initState() {
    super.initState();
    _appRouter = AppRouter(
      authBloc: widget.authBloc,
      onboardingBloc: widget.onboardingBloc,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Emotion Lab',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: ThemeMode.system,
      routerConfig: _appRouter.router,
    );
  }
}
