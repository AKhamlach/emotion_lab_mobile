import 'dart:async';

import 'package:flutter/material.dart';

import '../../../features/onboarding/bloc/onboarding_bloc.dart';

/// Bridges [OnboardingBloc] state into a [ChangeNotifier] for GoRouter's
/// `refreshListenable`.
class OnboardingGuard extends ChangeNotifier {
  OnboardingGuard({required OnboardingBloc onboardingBloc})
      : _onboardingBloc = onboardingBloc {
    _subscription = _onboardingBloc.stream.listen((state) {
      final complete = state is OnboardingComplete;
      if (_isOnboardingComplete != complete) {
        _isOnboardingComplete = complete;
        notifyListeners();
      }
    });
  }

  final OnboardingBloc _onboardingBloc;
  late final StreamSubscription<OnboardingState> _subscription;
  bool _isOnboardingComplete = false;

  bool get isOnboardingComplete => _isOnboardingComplete;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
