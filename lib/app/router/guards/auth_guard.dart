import 'dart:async';

import 'package:flutter/material.dart';

import '../../../features/auth/bloc/auth_bloc.dart';

/// Bridges [AuthBloc] state into a [ChangeNotifier] for GoRouter's
/// `refreshListenable`.
class AuthGuard extends ChangeNotifier {
  AuthGuard({required AuthBloc authBloc}) : _authBloc = authBloc {
    _subscription = _authBloc.stream.listen((state) {
      final authenticated = state is Authenticated;
      if (_isAuthenticated != authenticated) {
        _isAuthenticated = authenticated;
        notifyListeners();
      }
    });
  }

  final AuthBloc _authBloc;
  late final StreamSubscription<AuthState> _subscription;
  bool _isAuthenticated = false;

  bool get isAuthenticated => _isAuthenticated;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
