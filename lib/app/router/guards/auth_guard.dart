import 'package:flutter/material.dart';

/// Provides auth state for route guards.
///
/// Uses mock boolean flags during UI-first development.
/// Will be replaced by AuthBloc in Phase 9.
class AuthGuard extends ChangeNotifier {
  bool _isAuthenticated = false;

  bool get isAuthenticated => _isAuthenticated;

  set isAuthenticated(bool value) {
    if (_isAuthenticated != value) {
      _isAuthenticated = value;
      notifyListeners();
    }
  }
}
