part of 'onboarding_bloc.dart';

sealed class OnboardingEvent extends Equatable {
  const OnboardingEvent();

  @override
  List<Object?> get props => [];
}

final class OnboardingStarted extends OnboardingEvent {
  const OnboardingStarted();
}

final class AnswerUpdated extends OnboardingEvent {
  const AnswerUpdated({
    required this.questionId,
    this.selectedOption,
    this.selectedOptions,
    this.sliderValue,
    this.freeText,
  });

  final String questionId;
  final String? selectedOption;
  final List<String>? selectedOptions;
  final double? sliderValue;
  final String? freeText;

  @override
  List<Object?> get props => [
        questionId,
        selectedOption,
        selectedOptions,
        sliderValue,
        freeText,
      ];
}

final class QuestionNavigated extends OnboardingEvent {
  const QuestionNavigated(this.direction);

  final NavigationDirection direction;

  @override
  List<Object?> get props => [direction];
}

enum NavigationDirection { forward, backward }

final class OnboardingCompleted extends OnboardingEvent {
  const OnboardingCompleted();
}
