part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

final class AuthCheckRequested extends AuthEvent {
  const AuthCheckRequested();
}

final class LoginRequested extends AuthEvent {
  const LoginRequested({required this.email, required this.password});

  final String email;
  final String password;

  @override
  List<Object?> get props => [email, password];
}

final class RegisterRequested extends AuthEvent {
  const RegisterRequested({required this.email, required this.password});

  final String email;
  final String password;

  @override
  List<Object?> get props => [email, password];
}

final class ForgotPasswordRequested extends AuthEvent {
  const ForgotPasswordRequested({required this.email});

  final String email;

  @override
  List<Object?> get props => [email];
}

final class LogoutRequested extends AuthEvent {
  const LogoutRequested();
}
