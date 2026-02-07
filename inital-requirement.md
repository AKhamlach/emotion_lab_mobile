This app should be build with flutter and have the following features

## Psychometric Tests (Onboarding Calibration)

-Onboarding is mandatory and cannot be skipped
-One-question-per-screen flow (Typeform style)
-Smooth transitions between questions
-Show progress indicator
-Questions include:
    Personality (MBTI/Big Five–style simplified)
    Work habit
    Stress triggers
-Answers saved progressively (avoid data loss)
-Calibration must complete before unlocking the app
-Generate hidden user profile from results
-Validation to prevent unanswered questions
-Local draft saving if user exits mid-test
-Results must not be directly visible to the user unless product requires it

## AI Chatbot

-Chat interface must feel conversational and minimal
-Personality-aware responses based on onboarding data
-Tone must be:
    Supportive
    Non-judgmental
    Motivational
-AI must not provide:
    Medical advice
    Psychological diagnosis
-Display typing indicator for realism
-Allow message history context (within limits)
-Rate-limit user messages to prevent abuse
-Distress keyword detection:
    Trigger emergency/help UI
    Pause AI responses
-Quick-reply suggestions (optional)
-Ability to clear chat history
-Clear disclaimer about AI limitations

## User Matching (Motivational Buddy)

-Matching based on:
    Personality compatibility
    Work rhythm compatibility
    Stress level alignment
-Matching must use anonymized profiles
-Show only pseudonyms and minimal info
-Users must:
    Accept or decline matches
-Mutual acceptance required to connect
-Allow rematching after decline
-Buddy chat must be real-time
-Optional identity reveal only with mutual consent
-Block/report functionality required
-Prevent excessive rematching spam

## Gamification

-Gamification must feel light and positive (not competitive)
-Reward consistency, not performance comparison
Examples:
    Daily check-in streaks
    Completing onboarding
    Supporting a buddy
    Regular chatbot usage
    Points and badges system
    Visual progress indicators
    Gentle celebratory animations
    No public leaderboards (to avoid pressure)
    Encourage intrinsic motivation over rewards
    Avoid addictive mechanics

## Emotional Safety

-Distress detection integrated across chat & inputs
-Emergency help card accessible anytime
-Provide local support contacts if needed
-Clear messaging that app is not therapy
-Easy access to privacy and safety info
-Report inappropriate buddy behavior

## Privacy & Anonymity

-Pseudonym-based identity by default
-No real name required
-Users control what they reveal
-Clear consent before data usage
-Easy account deletion flow
-Transparency on data handling



## UI

-Dark & Light mode
-Theme must be switchable via Settings (not hardcoded)
-Bottom navigation bar for main pages
-Consistent design system (colors, typography, spacing)
-Typeform-like onboarding flow (one question per screen)
-Smooth transitions and subtle animations
-Responsive layout for small/medium/large screens
-Use safe areas for notches and system UI
-Loading states, empty states, and error states for all major screens
-Accessibility-friendly font scaling support

## UX Principles

-Simple and distraction-free interface
-Minimal cognitive load
-Friendly and reassuring tone in UI copy
-Avoid overwhelming users with too many actions per screen
-Onboarding must feel fast and engaging
-No skip allowed in mandatory calibration flow


## Navigation

-Use declarative routing (e.g., GoRouter)
-Guarded routes for:
    Auth-required pages
    Onboarding completion
-Predictable back navigation behavior

## State Management

-Use  Bloc
-Clear separation between:
-UI state
-Business logic
-Data layer
-Avoid storing business logic inside widgets

## Code Style

-Ensure proper separation of concerns
-Prefer small widgets to large ones
-Prefer using flex values rather than hardcoded sizes in Rows/Columns
-Avoid magic numbers (use constants)
-Use const constructors where possible
-Follow Dart lint rules (flutter_lints)
-Document public methods and complex logic
-Keep widget build methods readable

## Theming

-Centralized ThemeData configuration
-No inline colors or styles in widgets
-Support:
    Light theme
    Dark theme
-Theme persisted locally
-Use semantic color naming (e.g., primary, surface, error)

## Security

-Secure token storage (flutter_secure_storage)
-No sensitive data in logs
-Certificate pinning (recommended)
-Input validation on client side
-Auto logout on token expiration

## Performance

-Avoid unnecessary rebuilds
-Use const widgets where possible
-Lazy load heavy screens
-Paginate long lists
-Optimize images and assets

## Accessibility

-Semantic labels for important UI elements
-Sufficient color contrast
-Support screen readers
-Large tap targets

## Error Handling

-Global error handler
-Friendly user-facing error messages
-Offline handling where possible
-Graceful API failure UI

## Testing

-Unit tests for business logic
-Widget tests for key screens
-Integration tests for:
-Auth flow
-Onboarding flow
-Minimum test coverage target (e.g., 60–70%)