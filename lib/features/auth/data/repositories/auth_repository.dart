import '../../../../shared/models/auth_user.dart';

/// Abstract contract for authentication operations.
abstract class AuthRepository {
  Future<AuthUser> login({required String email, required String password});

  Future<AuthUser> register({required String email, required String password});

  Future<void> sendPasswordReset({required String email});

  Future<AuthUser?> getCurrentUser();

  Future<void> logout();
}
