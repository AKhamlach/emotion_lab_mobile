import 'package:flutter/material.dart';

/// Provides onboarding completion state for route guards.
///
/// Uses mock boolean flags during UI-first development.
/// Will be replaced by AuthBloc in Phase 9.
class OnboardingGuard extends ChangeNotifier {
  bool _isOnboardingComplete = false;

  bool get isOnboardingComplete => _isOnboardingComplete;

  set isOnboardingComplete(bool value) {
    if (_isOnboardingComplete != value) {
      _isOnboardingComplete = value;
      notifyListeners();
    }
  }
}
