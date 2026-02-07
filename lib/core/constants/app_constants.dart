abstract final class AppConstants {
  // ─── Onboarding ───
  static const int totalQuestions = 15;
  static const int personalityQuestions = 5;
  static const int workHabitQuestions = 5;
  static const int stressQuestions = 5;

  // ─── Splash ───
  static const int splashDurationMs = 2000;

  // ─── Chat ───
  static const int chatRateLimitPerMinute = 10;
  static const int chatRateLimitWindowMs = 60000;
  static const int maxMessageLength = 500;
  static const int typingIndicatorDelayMs = 1500;

  // ─── Auth ───
  static const int passwordMinLength = 8;
  static const int pseudonymMaxLength = 20;

  // ─── Buddy ───
  static const int maxActiveBuddies = 5;
  static const double highCompatibilityThreshold = 0.7;
  static const double mediumCompatibilityThreshold = 0.4;

  // ─── Gamification ───
  static const int pointsPerMessage = 5;
  static const int pointsPerCheckIn = 10;
  static const int pointsPerOnboarding = 50;
  static const int pointsPerBuddyConnect = 25;

  // ─── Disclaimers ───
  static const String aiDisclaimer =
      'This AI assistant is not a therapist or medical professional. '
      'It cannot provide diagnoses, treatment plans, or medical advice. '
      'If you are in crisis, please contact emergency services.';

  static const String appDisclaimer =
      'Emotion Lab is designed for emotional wellness support only. '
      'It is not a substitute for professional mental health care.';

  static const String privacyNotice =
      'Your data is stored securely and anonymously. '
      'You can delete your account and all associated data at any time.';
}
