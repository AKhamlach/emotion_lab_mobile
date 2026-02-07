import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/bloc/auth_bloc.dart';
import '../../features/auth/presentation/screens/forgot_password_screen.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/register_screen.dart';
import '../../features/buddy/presentation/screens/buddy_chat_screen.dart';
import '../../features/buddy/presentation/screens/buddy_discovery_screen.dart';
import '../../features/buddy/presentation/screens/buddy_profile_screen.dart';
import '../../features/chatbot/presentation/screens/chat_screen.dart';
import '../../features/gamification/presentation/screens/achievements_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/onboarding/bloc/onboarding_bloc.dart';
import '../../features/onboarding/presentation/screens/onboarding_complete_screen.dart';
import '../../features/onboarding/presentation/screens/question_screen.dart';
import '../../features/onboarding/presentation/screens/welcome_screen.dart';
import '../../features/safety/presentation/screens/emergency_help_screen.dart';
import '../../features/settings/presentation/screens/about_screen.dart';
import '../../features/settings/presentation/screens/privacy_info_screen.dart';
import '../../features/settings/presentation/screens/settings_screen.dart';
import '../../features/shell/presentation/screens/main_shell_screen.dart';
import '../../features/splash/presentation/screens/splash_screen.dart';
import 'guards/auth_guard.dart';
import 'guards/onboarding_guard.dart';
import 'route_names.dart';

class AppRouter {
  AppRouter({
    required AuthBloc authBloc,
    required OnboardingBloc onboardingBloc,
  })  : _authGuard = AuthGuard(authBloc: authBloc),
        _onboardingGuard = OnboardingGuard(onboardingBloc: onboardingBloc);

  final AuthGuard _authGuard;
  final OnboardingGuard _onboardingGuard;

  /// Navigation keys for the shell branches.
  final _rootNavigatorKey = GlobalKey<NavigatorState>();
  final _shellNavigatorKey = GlobalKey<NavigatorState>();

  late final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: RouteNames.splashPath,
    debugLogDiagnostics: true,
    refreshListenable: Listenable.merge([_authGuard, _onboardingGuard]),
    redirect: _globalRedirect,
    routes: [
      // ─── Splash ───
      GoRoute(
        path: RouteNames.splashPath,
        name: RouteNames.splash,
        builder: (context, state) => const SplashScreen(),
      ),

      // ─── Auth (unauthenticated) ───
      GoRoute(
        path: RouteNames.loginPath,
        name: RouteNames.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: RouteNames.registerPath,
        name: RouteNames.register,
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: RouteNames.forgotPasswordPath,
        name: RouteNames.forgotPassword,
        builder: (context, state) => const ForgotPasswordScreen(),
      ),

      // ─── Onboarding (authenticated, first-time) ───
      GoRoute(
        path: RouteNames.welcomePath,
        name: RouteNames.welcome,
        builder: (context, state) => const WelcomeScreen(),
      ),
      GoRoute(
        path: RouteNames.onboardingPath,
        name: RouteNames.onboarding,
        builder: (context, state) => const QuestionScreen(),
      ),
      GoRoute(
        path: RouteNames.onboardingCompletePath,
        name: RouteNames.onboardingComplete,
        builder: (context, state) => const OnboardingCompleteScreen(),
      ),

      // ─── Emergency (always accessible) ───
      GoRoute(
        path: RouteNames.emergencyPath,
        name: RouteNames.emergency,
        builder: (context, state) => const EmergencyHelpScreen(),
      ),

      // ─── Achievements ───
      GoRoute(
        path: RouteNames.achievementsPath,
        name: RouteNames.achievements,
        builder: (context, state) => const AchievementsScreen(),
      ),

      // ─── Main Shell (authenticated + onboarded) ───
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) => MainShellScreen(child: child),
        routes: [
          // Home tab
          GoRoute(
            path: RouteNames.homePath,
            name: RouteNames.home,
            builder: (context, state) => const HomeScreen(),
          ),

          // Chat tab
          GoRoute(
            path: RouteNames.chatPath,
            name: RouteNames.chat,
            builder: (context, state) => const ChatScreen(),
          ),

          // Buddy tab + sub-routes
          GoRoute(
            path: RouteNames.buddyPath,
            name: RouteNames.buddy,
            builder: (context, state) => const BuddyDiscoveryScreen(),
            routes: [
              GoRoute(
                path: ':id/${RouteNames.buddyChatPath}',
                name: RouteNames.buddyChat,
                parentNavigatorKey: _rootNavigatorKey,
                builder: (context, state) => BuddyChatScreen(
                  buddyId: state.pathParameters['id']!,
                ),
              ),
              GoRoute(
                path: ':id/${RouteNames.buddyProfilePath}',
                name: RouteNames.buddyProfile,
                parentNavigatorKey: _rootNavigatorKey,
                builder: (context, state) => BuddyProfileScreen(
                  buddyId: state.pathParameters['id']!,
                ),
              ),
            ],
          ),

          // Settings tab + sub-routes
          GoRoute(
            path: RouteNames.settingsPath,
            name: RouteNames.settings,
            builder: (context, state) => const SettingsScreen(),
            routes: [
              GoRoute(
                path: RouteNames.privacyInfoPath,
                name: RouteNames.privacyInfo,
                parentNavigatorKey: _rootNavigatorKey,
                builder: (context, state) => const PrivacyInfoScreen(),
              ),
              GoRoute(
                path: RouteNames.aboutPath,
                name: RouteNames.about,
                parentNavigatorKey: _rootNavigatorKey,
                builder: (context, state) => const AboutScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );

  // ─── Global redirect logic ───

  static const _unauthenticatedRoutes = {
    RouteNames.splashPath,
    RouteNames.loginPath,
    RouteNames.registerPath,
    RouteNames.forgotPasswordPath,
  };

  static const _onboardingRoutes = {
    RouteNames.welcomePath,
    RouteNames.onboardingPath,
    RouteNames.onboardingCompletePath,
  };

  String? _globalRedirect(BuildContext context, GoRouterState state) {
    final currentPath = state.matchedLocation;
    final isAuthenticated = _authGuard.isAuthenticated;
    final isOnboardingComplete = _onboardingGuard.isOnboardingComplete;

    // Emergency is always accessible — no redirects
    if (currentPath == RouteNames.emergencyPath) return null;

    // Splash handles its own navigation — no redirects
    if (currentPath == RouteNames.splashPath) return null;

    final isOnUnauthRoute = _unauthenticatedRoutes.contains(currentPath);
    final isOnOnboardingRoute = _onboardingRoutes.contains(currentPath);

    // Not authenticated → force to login (unless already on an unauth route)
    if (!isAuthenticated) {
      return isOnUnauthRoute ? null : RouteNames.loginPath;
    }

    // Authenticated but on login/register → redirect away
    if (isAuthenticated && isOnUnauthRoute) {
      return isOnboardingComplete
          ? RouteNames.homePath
          : RouteNames.welcomePath;
    }

    // Authenticated but onboarding not done → force to onboarding
    if (!isOnboardingComplete && !isOnOnboardingRoute) {
      return RouteNames.welcomePath;
    }

    // Onboarding complete but still on onboarding routes → go home
    if (isOnboardingComplete && isOnOnboardingRoute) {
      return RouteNames.homePath;
    }

    return null;
  }
}
