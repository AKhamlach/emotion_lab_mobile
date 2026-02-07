import 'package:equatable/equatable.dart';

class UserProfile extends Equatable {
  const UserProfile({
    required this.pseudonym,
    this.personalityTraits = const {},
    this.workHabits = const {},
    this.stressTriggers = const {},
    this.isOnboardingComplete = false,
  });

  final String pseudonym;

  /// Key-value pairs derived from personality questions.
  /// e.g. {'introvert_extrovert': 'introvert', 'openness': 'high'}
  final Map<String, String> personalityTraits;

  /// Key-value pairs derived from work habit questions.
  /// e.g. {'schedule': 'flexible', 'collaboration': 'solo'}
  final Map<String, String> workHabits;

  /// Key-value pairs derived from stress trigger questions.
  /// e.g. {'primary_trigger': 'deadlines', 'coping': 'exercise'}
  final Map<String, String> stressTriggers;

  final bool isOnboardingComplete;

  UserProfile copyWith({
    String? pseudonym,
    Map<String, String>? personalityTraits,
    Map<String, String>? workHabits,
    Map<String, String>? stressTriggers,
    bool? isOnboardingComplete,
  }) {
    return UserProfile(
      pseudonym: pseudonym ?? this.pseudonym,
      personalityTraits: personalityTraits ?? this.personalityTraits,
      workHabits: workHabits ?? this.workHabits,
      stressTriggers: stressTriggers ?? this.stressTriggers,
      isOnboardingComplete: isOnboardingComplete ?? this.isOnboardingComplete,
    );
  }

  @override
  List<Object?> get props => [
        pseudonym,
        personalityTraits,
        workHabits,
        stressTriggers,
        isOnboardingComplete,
      ];
}
