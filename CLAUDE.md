# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Emotion Lab Mobile is a Flutter application for mental health and emotional support. It includes psychometric onboarding, an AI chatbot, anonymous buddy matching, and gamification. The project is currently in early-stage scaffolding (default Flutter template).

## Build & Development Commands

```bash
# Install dependencies
flutter pub get

# Run the app (debug mode)
flutter run

# Build for release
flutter build apk          # Android
flutter build ios           # iOS
flutter build web           # Web

# Run all tests
flutter test

# Run a single test file
flutter test test/widget_test.dart

# Static analysis (linting)
flutter analyze

# Format code
dart format .
```

## Architecture Requirements

Per `inital-requirement.md`, the app should be built with:

- **State Management**: BLoC pattern — clear separation between UI state, business logic, and data layer. No business logic inside widgets.
- **Navigation**: GoRouter with declarative routing. Guarded routes for auth-required pages and onboarding completion.
- **Security**: `flutter_secure_storage` for token storage. Auto logout on token expiration.
- **Theming**: Centralized `ThemeData` with light/dark mode support. No inline colors or styles — use semantic color naming (`primary`, `surface`, `error`). Theme preference persisted locally.

## Code Style Rules

- Prefer small widgets over large monolithic ones
- Use `const` constructors wherever possible
- Use flex values instead of hardcoded sizes in Rows/Columns
- Avoid magic numbers — define constants
- Follow `flutter_lints` rules (configured in `analysis_options.yaml`)
- No sensitive data in logs

## Key Features to Implement

1. **Authentication** — email/password login & registration, Google & Apple social login (mocked), forgot password flow, secure token storage, auto-logout on token expiry
2. **Psychometric onboarding** — mandatory on first login, one-question-per-screen (Typeform-style), progressive saving, local draft persistence
3. **AI chatbot** — personality-aware responses, distress keyword detection with emergency UI, typing indicator, rate limiting
4. **Buddy matching** — anonymized profiles with pseudonyms, mutual accept, real-time chat, block/report
5. **Gamification** — streaks, points, badges; light/positive tone, no leaderboards
6. **Emotional safety** — distress detection across all inputs, emergency help card always accessible

## App Flow

```
Splash → (not logged in?) → Login/Register → (first time?) → Welcome → Onboarding → Home
Splash → (logged in + onboarding done) → Home
Splash → (logged in + onboarding NOT done) → Welcome → Onboarding → Home
```

## SDK Requirements

- Dart SDK: `^3.10.8`
- Flutter: `3.18.0+`
