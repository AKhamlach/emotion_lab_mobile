import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/errors/error_handler.dart';
import '../../../shared/models/psychometric_answer.dart';
import '../../../shared/models/psychometric_question.dart';
import '../data/repositories/onboarding_repository.dart';

part 'onboarding_event.dart';
part 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  OnboardingBloc({required OnboardingRepository onboardingRepository})
      : _onboardingRepository = onboardingRepository,
        super(const OnboardingInitial()) {
    on<OnboardingStarted>(_onStarted);
    on<AnswerUpdated>(_onAnswerUpdated);
    on<QuestionNavigated>(_onQuestionNavigated);
    on<OnboardingCompleted>(_onCompleted);
  }

  final OnboardingRepository _onboardingRepository;

  Future<void> _onStarted(
    OnboardingStarted event,
    Emitter<OnboardingState> emit,
  ) async {
    try {
      final questions = await _onboardingRepository.getQuestions();
      emit(OnboardingInProgress(
        questions: questions,
        answers: const {},
      ));
    } catch (e) {
      emit(OnboardingError(ErrorHandler.userMessage(e)));
    }
  }

  void _onAnswerUpdated(
    AnswerUpdated event,
    Emitter<OnboardingState> emit,
  ) {
    final current = state;
    if (current is! OnboardingInProgress) return;

    final existing = current.answerFor(event.questionId);
    final updated = PsychometricAnswer(
      questionId: event.questionId,
      selectedOption: event.selectedOption ?? existing.selectedOption,
      selectedOptions: event.selectedOptions ?? existing.selectedOptions,
      sliderValue: event.sliderValue ?? existing.sliderValue,
      freeText: event.freeText ?? existing.freeText,
    );

    emit(current.copyWith(
      answers: {...current.answers, event.questionId: updated},
    ));
  }

  void _onQuestionNavigated(
    QuestionNavigated event,
    Emitter<OnboardingState> emit,
  ) {
    final current = state;
    if (current is! OnboardingInProgress) return;

    final newIndex = event.direction == NavigationDirection.forward
        ? current.currentIndex + 1
        : current.currentIndex - 1;

    if (newIndex < 0 || newIndex >= current.questions.length) return;

    emit(current.copyWith(currentIndex: newIndex));
  }

  Future<void> _onCompleted(
    OnboardingCompleted event,
    Emitter<OnboardingState> emit,
  ) async {
    final current = state;
    if (current is! OnboardingInProgress) return;

    emit(const OnboardingSubmitting());
    try {
      await _onboardingRepository.submitAnswers(current.answers);
      emit(const OnboardingComplete());
    } catch (e) {
      emit(OnboardingError(ErrorHandler.userMessage(e)));
    }
  }
}
