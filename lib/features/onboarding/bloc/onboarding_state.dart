part of 'onboarding_bloc.dart';

sealed class OnboardingState extends Equatable {
  const OnboardingState();

  @override
  List<Object?> get props => [];
}

final class OnboardingInitial extends OnboardingState {
  const OnboardingInitial();
}

final class OnboardingInProgress extends OnboardingState {
  const OnboardingInProgress({
    required this.questions,
    required this.answers,
    this.currentIndex = 0,
  });

  final List<PsychometricQuestion> questions;
  final Map<String, PsychometricAnswer> answers;
  final int currentIndex;

  PsychometricAnswer answerFor(String questionId) {
    return answers[questionId] ??
        PsychometricAnswer(questionId: questionId);
  }

  bool get isCurrentAnswered => answerFor(questions[currentIndex].id).isAnswered;

  bool get isLastQuestion => currentIndex == questions.length - 1;

  double get progress => (currentIndex + 1) / questions.length;

  OnboardingInProgress copyWith({
    List<PsychometricQuestion>? questions,
    Map<String, PsychometricAnswer>? answers,
    int? currentIndex,
  }) {
    return OnboardingInProgress(
      questions: questions ?? this.questions,
      answers: answers ?? this.answers,
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }

  @override
  List<Object?> get props => [questions, answers, currentIndex];
}

final class OnboardingSubmitting extends OnboardingState {
  const OnboardingSubmitting();
}

final class OnboardingComplete extends OnboardingState {
  const OnboardingComplete();
}

final class OnboardingError extends OnboardingState {
  const OnboardingError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
