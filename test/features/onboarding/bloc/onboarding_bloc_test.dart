import 'package:bloc_test/bloc_test.dart';
import 'package:emotion_lab_mobile/features/onboarding/bloc/onboarding_bloc.dart';
import 'package:emotion_lab_mobile/features/onboarding/data/repositories/onboarding_repository.dart';
import 'package:emotion_lab_mobile/shared/models/psychometric_answer.dart';
import 'package:emotion_lab_mobile/shared/models/psychometric_question.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockOnboardingRepository extends Mock implements OnboardingRepository {}

const _testQuestions = <PsychometricQuestion>[
  PsychometricQuestion(
    id: 'q1',
    text: 'Question 1',
    category: QuestionCategory.personality,
    type: QuestionType.singleChoice,
    options: ['A', 'B', 'C'],
  ),
  PsychometricQuestion(
    id: 'q2',
    text: 'Question 2',
    category: QuestionCategory.workHabit,
    type: QuestionType.multiChoice,
    options: ['X', 'Y', 'Z'],
  ),
  PsychometricQuestion(
    id: 'q3',
    text: 'Question 3',
    category: QuestionCategory.stressTrigger,
    type: QuestionType.slider,
    sliderMin: 1,
    sliderMax: 5,
  ),
];

void main() {
  late MockOnboardingRepository mockRepo;

  setUp(() {
    mockRepo = MockOnboardingRepository();
    registerFallbackValue(<String, PsychometricAnswer>{});
  });

  group('OnboardingBloc', () {
    blocTest<OnboardingBloc, OnboardingState>(
      'initial state is OnboardingInitial',
      build: () => OnboardingBloc(onboardingRepository: mockRepo),
      verify: (bloc) => expect(bloc.state, const OnboardingInitial()),
    );

    group('OnboardingStarted', () {
      blocTest<OnboardingBloc, OnboardingState>(
        'emits OnboardingInProgress with loaded questions',
        build: () {
          when(() => mockRepo.getQuestions())
              .thenAnswer((_) async => _testQuestions);
          return OnboardingBloc(onboardingRepository: mockRepo);
        },
        act: (bloc) => bloc.add(const OnboardingStarted()),
        expect: () => [
          const OnboardingInProgress(
            questions: _testQuestions,
            answers: {},
          ),
        ],
      );

      blocTest<OnboardingBloc, OnboardingState>(
        'emits OnboardingError on failure',
        build: () {
          when(() => mockRepo.getQuestions())
              .thenThrow(Exception('Network error'));
          return OnboardingBloc(onboardingRepository: mockRepo);
        },
        act: (bloc) => bloc.add(const OnboardingStarted()),
        expect: () => [
          const OnboardingError('Something went wrong. Please try again.'),
        ],
      );
    });

    group('AnswerUpdated', () {
      blocTest<OnboardingBloc, OnboardingState>(
        'updates single choice answer',
        build: () {
          when(() => mockRepo.getQuestions())
              .thenAnswer((_) async => _testQuestions);
          return OnboardingBloc(onboardingRepository: mockRepo);
        },
        seed: () => const OnboardingInProgress(
          questions: _testQuestions,
          answers: {},
        ),
        act: (bloc) => bloc.add(const AnswerUpdated(
          questionId: 'q1',
          selectedOption: 'A',
        )),
        expect: () => [
          const OnboardingInProgress(
            questions: _testQuestions,
            answers: {
              'q1': PsychometricAnswer(
                questionId: 'q1',
                selectedOption: 'A',
              ),
            },
          ),
        ],
      );

      blocTest<OnboardingBloc, OnboardingState>(
        'updates multi-choice answer',
        build: () => OnboardingBloc(onboardingRepository: mockRepo),
        seed: () => const OnboardingInProgress(
          questions: _testQuestions,
          answers: {},
        ),
        act: (bloc) => bloc.add(const AnswerUpdated(
          questionId: 'q2',
          selectedOptions: ['X', 'Z'],
        )),
        expect: () => [
          const OnboardingInProgress(
            questions: _testQuestions,
            answers: {
              'q2': PsychometricAnswer(
                questionId: 'q2',
                selectedOptions: ['X', 'Z'],
              ),
            },
          ),
        ],
      );

      blocTest<OnboardingBloc, OnboardingState>(
        'updates slider answer',
        build: () => OnboardingBloc(onboardingRepository: mockRepo),
        seed: () => const OnboardingInProgress(
          questions: _testQuestions,
          answers: {},
        ),
        act: (bloc) => bloc.add(const AnswerUpdated(
          questionId: 'q3',
          sliderValue: 3.0,
        )),
        expect: () => [
          const OnboardingInProgress(
            questions: _testQuestions,
            answers: {
              'q3': PsychometricAnswer(
                questionId: 'q3',
                sliderValue: 3.0,
              ),
            },
          ),
        ],
      );

      blocTest<OnboardingBloc, OnboardingState>(
        'does nothing when not in OnboardingInProgress',
        build: () => OnboardingBloc(onboardingRepository: mockRepo),
        act: (bloc) => bloc.add(const AnswerUpdated(
          questionId: 'q1',
          selectedOption: 'A',
        )),
        expect: () => <OnboardingState>[],
      );
    });

    group('QuestionNavigated', () {
      blocTest<OnboardingBloc, OnboardingState>(
        'navigates forward',
        build: () => OnboardingBloc(onboardingRepository: mockRepo),
        seed: () => const OnboardingInProgress(
          questions: _testQuestions,
          answers: {},
          currentIndex: 0,
        ),
        act: (bloc) => bloc.add(
          const QuestionNavigated(NavigationDirection.forward),
        ),
        expect: () => [
          const OnboardingInProgress(
            questions: _testQuestions,
            answers: {},
            currentIndex: 1,
          ),
        ],
      );

      blocTest<OnboardingBloc, OnboardingState>(
        'navigates backward',
        build: () => OnboardingBloc(onboardingRepository: mockRepo),
        seed: () => const OnboardingInProgress(
          questions: _testQuestions,
          answers: {},
          currentIndex: 2,
        ),
        act: (bloc) => bloc.add(
          const QuestionNavigated(NavigationDirection.backward),
        ),
        expect: () => [
          const OnboardingInProgress(
            questions: _testQuestions,
            answers: {},
            currentIndex: 1,
          ),
        ],
      );

      blocTest<OnboardingBloc, OnboardingState>(
        'does not navigate below 0',
        build: () => OnboardingBloc(onboardingRepository: mockRepo),
        seed: () => const OnboardingInProgress(
          questions: _testQuestions,
          answers: {},
          currentIndex: 0,
        ),
        act: (bloc) => bloc.add(
          const QuestionNavigated(NavigationDirection.backward),
        ),
        expect: () => <OnboardingState>[],
      );

      blocTest<OnboardingBloc, OnboardingState>(
        'does not navigate beyond last question',
        build: () => OnboardingBloc(onboardingRepository: mockRepo),
        seed: () => const OnboardingInProgress(
          questions: _testQuestions,
          answers: {},
          currentIndex: 2,
        ),
        act: (bloc) => bloc.add(
          const QuestionNavigated(NavigationDirection.forward),
        ),
        expect: () => <OnboardingState>[],
      );
    });

    group('OnboardingCompleted', () {
      blocTest<OnboardingBloc, OnboardingState>(
        'emits OnboardingSubmitting then OnboardingComplete on success',
        build: () {
          when(() => mockRepo.submitAnswers(any()))
              .thenAnswer((_) async {});
          return OnboardingBloc(onboardingRepository: mockRepo);
        },
        seed: () => const OnboardingInProgress(
          questions: _testQuestions,
          answers: {
            'q1': PsychometricAnswer(
              questionId: 'q1',
              selectedOption: 'A',
            ),
          },
          currentIndex: 2,
        ),
        act: (bloc) => bloc.add(const OnboardingCompleted()),
        expect: () => [
          const OnboardingSubmitting(),
          const OnboardingComplete(),
        ],
      );

      blocTest<OnboardingBloc, OnboardingState>(
        'emits OnboardingSubmitting then OnboardingError on failure',
        build: () {
          when(() => mockRepo.submitAnswers(any()))
              .thenThrow(Exception('Server error'));
          return OnboardingBloc(onboardingRepository: mockRepo);
        },
        seed: () => const OnboardingInProgress(
          questions: _testQuestions,
          answers: {},
          currentIndex: 2,
        ),
        act: (bloc) => bloc.add(const OnboardingCompleted()),
        expect: () => [
          const OnboardingSubmitting(),
          const OnboardingError('Something went wrong. Please try again.'),
        ],
      );
    });
  });
}
