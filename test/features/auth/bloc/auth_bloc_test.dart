import 'package:bloc_test/bloc_test.dart';
import 'package:emotion_lab_mobile/core/errors/app_exceptions.dart';
import 'package:emotion_lab_mobile/features/auth/bloc/auth_bloc.dart';
import 'package:emotion_lab_mobile/features/auth/data/repositories/auth_repository.dart';
import 'package:emotion_lab_mobile/shared/models/auth_user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late MockAuthRepository mockRepo;

  final testUser = AuthUser(
    id: 'test-id',
    email: 'test@example.com',
    pseudonym: 'Bright Panda',
    createdAt: DateTime(2024),
  );

  setUp(() {
    mockRepo = MockAuthRepository();
  });

  group('AuthBloc', () {
    blocTest<AuthBloc, AuthState>(
      'initial state is AuthInitial',
      build: () => AuthBloc(authRepository: mockRepo),
      verify: (bloc) => expect(bloc.state, const AuthInitial()),
    );

    group('AuthCheckRequested', () {
      blocTest<AuthBloc, AuthState>(
        'emits Authenticated when user exists',
        build: () {
          when(() => mockRepo.getCurrentUser())
              .thenAnswer((_) async => testUser);
          return AuthBloc(authRepository: mockRepo);
        },
        act: (bloc) => bloc.add(const AuthCheckRequested()),
        expect: () => [Authenticated(testUser)],
      );

      blocTest<AuthBloc, AuthState>(
        'emits Unauthenticated when no user',
        build: () {
          when(() => mockRepo.getCurrentUser())
              .thenAnswer((_) async => null);
          return AuthBloc(authRepository: mockRepo);
        },
        act: (bloc) => bloc.add(const AuthCheckRequested()),
        expect: () => [const Unauthenticated()],
      );

      blocTest<AuthBloc, AuthState>(
        'emits AuthError then Unauthenticated on failure',
        build: () {
          when(() => mockRepo.getCurrentUser())
              .thenThrow(const AuthException('Session expired'));
          return AuthBloc(authRepository: mockRepo);
        },
        act: (bloc) => bloc.add(const AuthCheckRequested()),
        expect: () => [
          const AuthError('Session expired'),
          const Unauthenticated(),
        ],
      );
    });

    group('LoginRequested', () {
      blocTest<AuthBloc, AuthState>(
        'emits AuthLoading then Authenticated on success',
        build: () {
          when(() => mockRepo.login(
                email: any(named: 'email'),
                password: any(named: 'password'),
              )).thenAnswer((_) async => testUser);
          return AuthBloc(authRepository: mockRepo);
        },
        act: (bloc) => bloc.add(const LoginRequested(
          email: 'test@example.com',
          password: 'password123',
        )),
        expect: () => [
          const AuthLoading(),
          Authenticated(testUser),
        ],
      );

      blocTest<AuthBloc, AuthState>(
        'emits AuthLoading, AuthError, Unauthenticated on failure',
        build: () {
          when(() => mockRepo.login(
                email: any(named: 'email'),
                password: any(named: 'password'),
              )).thenThrow(const AuthException('Invalid email or password.'));
          return AuthBloc(authRepository: mockRepo);
        },
        act: (bloc) => bloc.add(const LoginRequested(
          email: 'test@example.com',
          password: 'bad',
        )),
        expect: () => [
          const AuthLoading(),
          const AuthError('Invalid email or password.'),
          const Unauthenticated(),
        ],
      );
    });

    group('RegisterRequested', () {
      blocTest<AuthBloc, AuthState>(
        'emits AuthLoading then Authenticated on success',
        build: () {
          when(() => mockRepo.register(
                email: any(named: 'email'),
                password: any(named: 'password'),
              )).thenAnswer((_) async => testUser);
          return AuthBloc(authRepository: mockRepo);
        },
        act: (bloc) => bloc.add(const RegisterRequested(
          email: 'test@example.com',
          password: 'password123',
        )),
        expect: () => [
          const AuthLoading(),
          Authenticated(testUser),
        ],
      );

      blocTest<AuthBloc, AuthState>(
        'emits AuthLoading, AuthError, Unauthenticated on failure',
        build: () {
          when(() => mockRepo.register(
                email: any(named: 'email'),
                password: any(named: 'password'),
              )).thenThrow(const AuthException('Email already in use.'));
          return AuthBloc(authRepository: mockRepo);
        },
        act: (bloc) => bloc.add(const RegisterRequested(
          email: 'test@example.com',
          password: 'password123',
        )),
        expect: () => [
          const AuthLoading(),
          const AuthError('Email already in use.'),
          const Unauthenticated(),
        ],
      );
    });

    group('ForgotPasswordRequested', () {
      blocTest<AuthBloc, AuthState>(
        'emits AuthLoading then PasswordResetSent on success',
        build: () {
          when(() => mockRepo.sendPasswordReset(
                email: any(named: 'email'),
              )).thenAnswer((_) async {});
          return AuthBloc(authRepository: mockRepo);
        },
        act: (bloc) => bloc.add(const ForgotPasswordRequested(
          email: 'test@example.com',
        )),
        expect: () => [
          const AuthLoading(),
          const PasswordResetSent('test@example.com'),
        ],
      );

      blocTest<AuthBloc, AuthState>(
        'emits AuthLoading, AuthError, Unauthenticated on failure',
        build: () {
          when(() => mockRepo.sendPasswordReset(
                email: any(named: 'email'),
              )).thenThrow(const NetworkException());
          return AuthBloc(authRepository: mockRepo);
        },
        act: (bloc) => bloc.add(const ForgotPasswordRequested(
          email: 'test@example.com',
        )),
        expect: () => [
          const AuthLoading(),
          const AuthError('A network error occurred. Please try again.'),
          const Unauthenticated(),
        ],
      );
    });

    group('LogoutRequested', () {
      blocTest<AuthBloc, AuthState>(
        'emits Unauthenticated',
        build: () {
          when(() => mockRepo.logout()).thenAnswer((_) async {});
          return AuthBloc(authRepository: mockRepo);
        },
        act: (bloc) => bloc.add(const LogoutRequested()),
        expect: () => [const Unauthenticated()],
      );

      blocTest<AuthBloc, AuthState>(
        'emits Unauthenticated even on logout failure',
        build: () {
          when(() => mockRepo.logout())
              .thenThrow(const NetworkException());
          return AuthBloc(authRepository: mockRepo);
        },
        act: (bloc) => bloc.add(const LogoutRequested()),
        expect: () => [const Unauthenticated()],
      );
    });
  });
}
