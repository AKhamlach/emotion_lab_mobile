import 'package:uuid/uuid.dart';

import '../../../../core/errors/app_exceptions.dart';
import '../../../../shared/models/auth_user.dart';
import 'auth_repository.dart';

const _mockDelay = Duration(seconds: 1);

const _pseudonyms = [
  'Bright Panda',
  'Calm Dolphin',
  'Gentle Owl',
  'Quiet Fox',
  'Warm Koala',
];

class MockAuthRepository implements AuthRepository {
  MockAuthRepository();

  final _uuid = const Uuid();
  AuthUser? _currentUser;
  int _pseudonymIndex = 0;

  @override
  Future<AuthUser> login({
    required String email,
    required String password,
  }) async {
    await Future<void>.delayed(_mockDelay);

    if (password.length < 6) {
      throw const AuthException('Invalid email or password.');
    }

    _currentUser = AuthUser(
      id: _uuid.v4(),
      email: email,
      pseudonym: _pseudonyms[_pseudonymIndex++ % _pseudonyms.length],
      createdAt: DateTime.now(),
    );
    return _currentUser!;
  }

  @override
  Future<AuthUser> register({
    required String email,
    required String password,
  }) async {
    await Future<void>.delayed(_mockDelay);

    _currentUser = AuthUser(
      id: _uuid.v4(),
      email: email,
      pseudonym: _pseudonyms[_pseudonymIndex++ % _pseudonyms.length],
      createdAt: DateTime.now(),
    );
    return _currentUser!;
  }

  @override
  Future<void> sendPasswordReset({required String email}) async {
    await Future<void>.delayed(_mockDelay);
    // Mock: always succeeds
  }

  @override
  Future<AuthUser?> getCurrentUser() async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    return _currentUser;
  }

  @override
  Future<void> logout() async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    _currentUser = null;
  }
}
