# Emotion Lab Mobile — UI-First Implementation Plan

## Current State
- Fresh Flutter counter template — no architecture, no folders, no dependencies
- Dart SDK `^3.10.8`, only `cupertino_icons` and `flutter_lints` installed
- All requirements defined in `inital-requirement.md`

---

## Phase 1: Project Foundation

### 1.1 — Install Dependencies
**Modify**: `pubspec.yaml`
- `flutter_bloc`, `equatable` (state management)
- `go_router` (navigation)
- `flutter_secure_storage`, `shared_preferences` (storage)
- `flutter_animate`, `confetti_widget`, `shimmer` (animations/UI)
- `google_fonts`, `intl`, `uuid` (utilities)
- Dev: `bloc_test`, `mocktail`
- Add `assets/images/`, `assets/animations/`, `assets/icons/` asset dirs

### 1.2 — Create Folder Structure
```
lib/
  app/
    app.dart                        # Root MaterialApp.router
    router/
      app_router.dart               # GoRouter config
      route_names.dart              # Named route constants
      guards/                       # auth_guard.dart, onboarding_guard.dart
  core/
    constants/                      # app_constants.dart, asset_paths.dart
    theme/                          # app_theme.dart, app_colors.dart, app_text_styles.dart, app_dimensions.dart, theme_extensions.dart
    utils/extensions/               # context_extensions.dart
    utils/                          # distress_detector.dart, validators.dart
    errors/                         # error_handler.dart, app_exceptions.dart
    storage/                        # secure_storage_service.dart, local_storage_service.dart
  shared/
    widgets/buttons/                # primary_button, secondary_button, quick_reply_chip
    widgets/cards/                  # emergency_help_card, info_card, buddy_card, badge_card
    widgets/indicators/             # progress_bar, streak_indicator, typing_indicator, loading_indicator
    widgets/dialogs/                # confirm_dialog, emergency_dialog, report_dialog
    widgets/states/                 # empty_state, error_state, loading_state
    widgets/layout/                 # safe_area_wrapper, responsive_builder
    widgets/animations/             # celebration_animation, fade_slide_transition, pulse_animation
    models/                         # user_profile, chat_message, buddy_profile, badge, psychometric_question/answer, gamification_stats
    mock_data/                      # mock_questions, mock_messages, mock_buddies, mock_badges, mock_user_profile
  features/
    splash/presentation/screens/
    auth/presentation/{screens,widgets}/
    onboarding/presentation/{screens,widgets}/
    home/presentation/{screens,widgets}/
    chatbot/presentation/{screens,widgets}/
    buddy/presentation/{screens,widgets}/
    gamification/presentation/{screens,widgets}/
    settings/presentation/{screens,widgets}/
    safety/presentation/{screens,widgets}/
    shell/presentation/{screens,widgets}/
```

### 1.3 — Theme System
- `app_colors.dart` — Semantic color palettes (light + dark): primary, surface, error + custom extension colors (chatBubbleUser, chatBubbleAi, emergencyRed, streakOrange, badgeGold)
- `app_text_styles.dart` — Typography via Google Fonts (Inter/Nunito)
- `app_dimensions.dart` — Spacing (4/8/16/24/32/48), radii, icon sizes, tap target min (48), animation durations
- `theme_extensions.dart` — `ThemeExtension<AppThemeExtension>` for app-specific color tokens
- `app_theme.dart` — `ThemeData light()` and `dark()` factories assembling all above, component themes (buttons, inputs, cards, appbar, bottom nav)

### 1.4 — Constants & Utilities
- `app_constants.dart` — Rate limits, question count, splash duration, disclaimer text
- `context_extensions.dart` — `BuildContext` extension for theme/mediaQuery shortcuts
- `distress_detector.dart` — `bool containsDistressKeywords(String text)` static utility
- `error_handler.dart` — Global error handler for `FlutterError.onError`

### 1.5 — GoRouter Navigation
- `route_names.dart` — All named route constants
- `app_router.dart`:
  - `/splash` (initial)
  - `/login`, `/register` (unauthenticated routes)
  - `/welcome`, `/onboarding`, `/onboarding/complete` (first-time user flow)
  - `ShellRoute` with `MainShellScreen` for bottom nav tabs:
    - `/home`, `/chat`, `/buddy`, `/settings`
  - Sub-routes: `/buddy/:id/chat`, `/buddy/:id/profile`, `/settings/privacy`, `/settings/about`
  - `/emergency` (top-level, always accessible)
  - `/achievements` accessible from home
  - `/forgot-password` (unauthenticated)
  - Guards: `auth_guard` redirects unauthenticated users to `/login`, `onboarding_guard` redirects first-time users to `/welcome`
  - Guards use mock boolean flags (replaced by BLoC in Phase 9)

### 1.6 — App Entry Point
- **Modify**: `lib/main.dart` — Replace counter app with `EmotionLabApp`
- **Create**: `lib/app/app.dart` — `MaterialApp.router` with theme, darkTheme, routerConfig

### 1.7 — Shared Widgets (~23 widgets)
All use `const` constructors, `AppColors`/`AppDimensions` for styling, `Semantics` labels, 48px min tap targets.

**Buttons**: `PrimaryButton` (full-width, loading state), `SecondaryButton` (outlined), `QuickReplyChip`
**Cards**: `EmergencyHelpCard`, `InfoCard`, `BuddyCard`, `BadgeCard`
**Indicators**: `ProgressBar`, `StreakIndicator`, `TypingIndicator`, `LoadingIndicator`
**Dialogs**: `ConfirmDialog`, `EmergencyDialog`, `ReportDialog`
**States**: `EmptyStateWidget`, `ErrorStateWidget`, `LoadingStateWidget`
**Layout**: `SafeAreaWrapper`, `ResponsiveBuilder`
**Animations**: `CelebrationAnimation`, `FadeSlideTransition`, `PulseAnimation`

### 1.8 — Data Models
- `AuthUser` (id, email, pseudonym, createdAt, isEmailVerified)
- `PsychometricQuestion` (id, text, category, type, options) + `PsychometricAnswer`
- `UserProfile` (pseudonym, personality traits, work habits, stress triggers, onboardingComplete)
- `ChatMessage` (content, sender enum, timestamp, isDistressDetected)
- `BuddyProfile` (pseudonym, compatibilityScore, sharedTraits, status enum)
- `Badge` (name, description, iconAsset, isEarned, category enum)
- `GamificationStats` (points, streak, level, levelProgress, earnedBadges)

### 1.9 — Mock Data
- 15 psychometric questions (5 personality, 5 work habit, 5 stress triggers; mixed types)
- 6-8 sample chat messages (user/AI alternating)
- 3 buddy profiles with varying compatibility
- 8-10 badges (some earned, some locked)
- 1 completed user profile

---

## Phase 2: Authentication & Onboarding UI

### User Flow
```
Splash → (not logged in?) → Login/Register → (first time?) → Welcome → Onboarding → Complete → Home
Splash → (logged in, onboarding done?) → Home
Splash → (logged in, onboarding NOT done?) → Welcome → Onboarding → Complete → Home
```

### 2.1 — Splash Screen
`splash_screen.dart` — Logo fade-in, tagline, auto-navigate after 2s (checks auth state to decide next route)

### 2.2 — Login Screen
`login_screen.dart` — App logo, email field, password field (with visibility toggle), "Log In" primary button, "Forgot Password?" text button, divider with "OR", social login buttons (Google + Apple, mocked), "Don't have an account? Sign Up" link, form validation (email format, password min length)

### 2.3 — Register Screen
`register_screen.dart` — App logo, email field, password field + confirm password field (with visibility toggles), "Create Account" primary button, divider with "OR", social login buttons (Google + Apple, mocked), "Already have an account? Log In" link, form validation, terms & privacy links

### 2.4 — Forgot Password Screen
`forgot_password_screen.dart` — Back arrow, email field, "Send Reset Link" button, success state with "Check your inbox" message

### 2.5 — Auth Widgets
- `auth_header.dart` — Logo + title + subtitle (reused across login/register/forgot)
- `social_login_buttons.dart` — Google & Apple sign-in buttons (mocked, styled)
- `auth_form_field.dart` — Styled TextFormField with label, error display, optional suffix (visibility toggle)
- `auth_divider.dart` — Horizontal divider with centered "OR" text

### 2.6 — Welcome Screen
`welcome_screen.dart` — Illustration placeholder, warm welcome copy, "Get Started" button, "~3 minutes" subtitle, no skip

### 2.7 — Question Screen (Typeform Flow)
`question_screen.dart` — `PageView` with `NeverScrollableScrollPhysics`, one question at a time, `ProgressBar` at top, renders answer widget by `QuestionType` (singleChoice/multiChoice/slider/freeText), "Next" enabled only when answered, "Back" on all except first, category header

### 2.8 — Answer Widgets
- `question_card.dart` — Question text + category label + emoji
- `answer_option_tile.dart` — Tappable tile with selection animation
- `slider_answer.dart` — Labeled slider with min/max
- `text_answer_field.dart` — Styled TextField with character counter
- `progress_dots.dart` — Dot row alternative progress indicator
- `onboarding_page_transition.dart` — Custom slide+fade transition

### 2.9 — Onboarding Complete Screen
`onboarding_complete_screen.dart` — Confetti celebration, "You're all set!", pseudonym reveal, "Enter Emotion Lab" button

---

## Phase 3: Main App Shell UI

### 3.1 — Shell + Bottom Navigation
- `main_shell_screen.dart` — Scaffold with child from ShellRoute, `BottomNavBar`, `EmergencyFab`
- `bottom_nav_bar.dart` — 4 tabs: Home, Chat, Buddy, Settings; active/inactive colors; badge dot on Chat

### 3.2 — Home Dashboard
- `home_screen.dart` — ScrollView with greeting, mood check, streak summary, quick actions, safety banner
- `greeting_header.dart` — Time-based greeting + pseudonym
- `daily_mood_check.dart` — 5 emoji buttons (great→bad), selected state
- `streak_summary_card.dart` — Streak flame + points + badge count; tap → achievements
- `quick_actions_row.dart` — 3 action cards: Talk to AI, Find Buddy, My Badges
- `safety_banner.dart` — Subtle disclaimer with emergency link

---

## Phase 4: AI Chatbot UI

### 4.1 — Chat Screen
`chat_screen.dart` — AppBar (title + clear chat + emergency icon), `MessageList`, `ChatDisclaimerBanner`, `QuickRepliesRow`, `ChatInputBar`

### 4.2 — Chat Components
- `message_bubble.dart` — User (right, primary color) vs AI (left, surface color), timestamp
- `message_list.dart` — `ListView.builder` reverse, date separators, auto-scroll
- `chat_input_bar.dart` — TextField + send icon, enabled when non-empty, mock AI response on send
- `chat_typing_indicator.dart` — Typing dots in AI bubble
- `quick_replies_row.dart` — Scrollable chips ("I'm feeling stressed", "Tell me something positive")
- `chat_disclaimer_banner.dart` — Collapsible "Not therapy" disclaimer
- `distress_alert_overlay.dart` — Full-screen overlay on keyword detection, emergency contacts, dismiss
- `clear_chat_button.dart` — Confirmation dialog then clear

---

## Phase 5: Buddy Matching UI

### 5.1 — Buddy Discovery Screen
`buddy_discovery_screen.dart` — "Find a Buddy" AppBar, tab: Discover / My Buddies, list of match cards or empty state

### 5.2 — Buddy Components
- `buddy_match_card.dart` — Pseudonym, avatar circle, compatibility bar, shared traits, action buttons
- `buddy_compatibility_bar.dart` — Filled bar, color-coded (green >70%, yellow 40-70%)
- `buddy_action_buttons.dart` — Accept/Decline/Report; decline removes with slide animation
- `buddy_empty_state.dart` — "No matches yet" with subtitle
- `identity_reveal_prompt.dart` — Bottom sheet for mutual consent identity reveal

### 5.3 — Buddy Chat Screen
`buddy_chat_screen.dart` — Similar to AI chat, buddy pseudonym in AppBar, overflow menu (report/block/reveal), distress detection active

### 5.4 — Buddy Profile Screen
`buddy_profile_screen.dart` — Avatar, pseudonym, compatibility breakdown, shared traits, Chat CTA, block/report menu

---

## Phase 6: Gamification UI

### 6.1 — Achievements Screen
`achievements_screen.dart` — "My Journey" AppBar, points+level, streak calendar, badge grid

### 6.2 — Components
- `points_display.dart` — Large number + level badge
- `streak_calendar.dart` — 7-day or 30-day grid, filled/outlined/dotted circles
- `badge_grid.dart` — GridView of BadgeCards, earned (color) vs locked (grayscale)
- `badge_detail_sheet.dart` — Bottom sheet with large icon, name, how to earn
- `level_progress_bar.dart` — "Level 3" + XP bar (240/500)
- `celebration_overlay.dart` — Confetti + badge icon + "Badge Earned!" auto-dismiss

---

## Phase 7: Settings & Profile UI

### 7.1 — Settings Screen
`settings_screen.dart` — Header card (pseudonym + level + email), grouped list: Appearance, Notifications, Privacy, Emergency, About, Log Out, Delete Account

### 7.2 — Settings Components
- `theme_toggle_tile.dart` — Light/Dark/System segmented selector
- `logout_tile.dart` — Confirmation dialog, clears tokens, navigates to /login
- `delete_account_tile.dart` — Red text, multi-step confirmation (password re-entry), clears all data
- `notification_toggle.dart` — SwitchListTiles for reminders, buddy messages, achievements

### 7.3 — Privacy Info Screen
`privacy_info_screen.dart` — Scrollable content: what data is collected, anonymity, deletion, data handling

### 7.4 — About Screen
`about_screen.dart` — Logo, version, disclaimer, credits, placeholder links

---

## Phase 8: Emotional Safety UI

### 8.1 — Emergency Help Screen
`emergency_help_screen.dart` — "You're Not Alone" header, support contact cards (988, Crisis Text Line, 911), calming colors, "I'm feeling better" back navigation

### 8.2 — Safety Components
- `emergency_fab.dart` — Heart/shield icon FAB, always visible on shell, subtle pulse, navigates to /emergency
- `support_contact_card.dart` — Organization name, description, phone/text action areas
- `safety_disclaimer.dart` — Reusable "not therapy" banner

---

## Phase 9: State Management (BLoC)

### 9.1 — BLoC Foundation
- `bloc_observer.dart` — Custom observer for logging (no sensitive data)
- Update `main.dart` with `Bloc.observer`

### 9.2 — Theme BLoC
Events: `ThemeChanged`, `ThemeLoaded` | State: `ThemeState(ThemeMode)` | Persist to SharedPreferences
Wire into `app.dart` with `BlocProvider<ThemeBloc>`

### 9.3 — Onboarding BLoC
Events: `OnboardingStarted`, `AnswerSubmitted`, `NavigatedBack`, `OnboardingCompleted`, `DraftSaved/Loaded`
State: currentIndex, answers map, isComplete | Draft persistence to local storage

### 9.4 — Chat BLoC
Events: `MessageSent`, `ChatCleared`, `DistressDetected/Dismissed`
State: messages list, isTyping, isDistressAlertShown, rateLimitRemaining

### 9.5 — Buddy BLoC
Events: `MatchesLoaded`, `MatchAccepted/Declined`, `BuddyBlocked/Reported`, `IdentityRevealRequested`, `BuddyMessageSent`
State: availableMatches, connectedBuddies, currentChat

### 9.6 — Gamification BLoC
Events: `StatsLoaded`, `PointsEarned`, `StreakUpdated`, `BadgeEarned`
State: stats, showCelebration, newBadge

### 9.7 — Auth BLoC + Router Guards
Events: `AuthCheckRequested`, `LoginRequested`, `RegisterRequested`, `LogoutRequested`, `AccountDeleted`, `ForgotPasswordRequested`, `SocialLoginRequested(provider)`
State: AuthState (initial, loading, authenticated, unauthenticated, error) with AuthUser, isOnboardingComplete, errorMessage
- On login/register success: store token via SecureStorageService, check onboarding status
- On logout: clear token, navigate to /login
- On token expiry: auto-logout
- Wire into GoRouter redirect logic with `GoRouterRefreshStream`

### 9.8 — Storage Services
- `secure_storage_service.dart` — Wrapper for flutter_secure_storage (tokens)
- `local_storage_service.dart` — Wrapper for SharedPreferences (theme, drafts)

---

## Phase 10: Testing

### 10.1 — Unit Tests (BLoC + utilities)
- `auth_bloc_test.dart`, `distress_detector_test.dart`, `onboarding_bloc_test.dart`, `chat_bloc_test.dart`, `buddy_bloc_test.dart`, `gamification_bloc_test.dart`, `theme_bloc_test.dart`

### 10.2 — Widget Tests (key screens + components)
- `login_screen_test.dart`, `register_screen_test.dart`, `primary_button_test.dart`, `emergency_help_card_test.dart`, `progress_bar_test.dart`, `question_screen_test.dart`, `welcome_screen_test.dart`, `message_bubble_test.dart`, `chat_input_bar_test.dart`, `buddy_discovery_screen_test.dart`

### 10.3 — Integration Tests
- `auth_flow_test.dart` — Login → (first time) → onboarding → home; Login → (returning) → home; Logout → login
- `onboarding_flow_test.dart` — Welcome → all questions → complete → home
- `chat_flow_test.dart` — Send message → typing → response → distress keyword → emergency overlay
- `navigation_test.dart` — Tab switching, guard redirects, deep links

### 10.4 — Update default test
Replace counter smoke test with `EmotionLabApp` smoke test

---

## Phase Dependencies & Execution Order

```
Phase 1 (Foundation) ──────────────────────────────────────────────────┐
  ↓                                                                    │
Phase 2 (Auth + Onboarding UI) ← gates app entry                      │
  ↓                                                                    │
Phase 3 (Shell + Home) ← hosts all features                           │
  ↓                                                                    │
Phase 8 (Safety UI) ← crosscuts everything (FAB on shell)             │
  ↓                                                                    │
Phase 4 (Chatbot UI)      ┐                                           │
Phase 5 (Buddy UI)        ├── can be parallelized                     │
Phase 6 (Gamification UI) │                                           │
Phase 7 (Settings UI)     ┘                                           │
  ↓                                                                    │
Phase 9 (BLoC Integration) ← wires all UI to real state               │
  ↓                                                                    │
Phase 10 (Testing) ────────────────────────────────────────────────────┘
```

## Verification

After each phase:
1. `flutter analyze` — zero warnings
2. `flutter test` — all tests pass
3. `flutter run` — app launches and screens render correctly

Final verification:
- Login → first-time onboarding → home (end-to-end)
- Login → returning user → home (skip onboarding)
- Logout → redirected to login
- Complete onboarding flow end-to-end in the running app
- Navigate all tabs and sub-screens
- Toggle light/dark theme
- Trigger distress detection in chat
- Access emergency screen from FAB
- Run `flutter test --coverage` and verify 60-70% target
