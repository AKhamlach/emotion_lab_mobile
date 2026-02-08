import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app/app.dart';
import 'core/errors/error_handler.dart';
import 'features/auth/bloc/auth_bloc.dart';
import 'features/auth/data/repositories/mock_auth_repository.dart';
import 'features/home/bloc/home_bloc.dart';
import 'features/home/data/repositories/mock_home_repository.dart';
import 'features/onboarding/bloc/onboarding_bloc.dart';
import 'features/onboarding/data/repositories/mock_onboarding_repository.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  ErrorHandler.init();

  final authRepository = MockAuthRepository();
  final onboardingRepository = MockOnboardingRepository();
  final homeRepository = MockHomeRepository();

  final authBloc = AuthBloc(authRepository: authRepository);
  final onboardingBloc =
      OnboardingBloc(onboardingRepository: onboardingRepository);
  final homeBloc = HomeBloc(homeRepository: homeRepository);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider.value(value: authBloc),
        BlocProvider.value(value: onboardingBloc),
        BlocProvider.value(value: homeBloc),
      ],
      child: EmotionLabApp(
        authBloc: authBloc,
        onboardingBloc: onboardingBloc,
      ),
    ),
  );
}
