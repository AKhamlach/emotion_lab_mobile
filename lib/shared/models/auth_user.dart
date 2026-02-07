import 'package:equatable/equatable.dart';

class AuthUser extends Equatable {
  const AuthUser({
    required this.id,
    required this.email,
    required this.pseudonym,
    required this.createdAt,
    this.isEmailVerified = false,
  });

  final String id;
  final String email;
  final String pseudonym;
  final DateTime createdAt;
  final bool isEmailVerified;

  AuthUser copyWith({
    String? id,
    String? email,
    String? pseudonym,
    DateTime? createdAt,
    bool? isEmailVerified,
  }) {
    return AuthUser(
      id: id ?? this.id,
      email: email ?? this.email,
      pseudonym: pseudonym ?? this.pseudonym,
      createdAt: createdAt ?? this.createdAt,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
    );
  }

  @override
  List<Object?> get props => [id, email, pseudonym, createdAt, isEmailVerified];
}
