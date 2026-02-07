import '../../../../shared/mock_data/mock_questions.dart';
import '../../../../shared/models/psychometric_answer.dart';
import '../../../../shared/models/psychometric_question.dart';
import 'onboarding_repository.dart';

class MockOnboardingRepository implements OnboardingRepository {
  @override
  Future<List<PsychometricQuestion>> getQuestions() async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    return mockQuestions;
  }

  @override
  Future<void> submitAnswers(Map<String, PsychometricAnswer> answers) async {
    await Future<void>.delayed(const Duration(seconds: 1));
    // Mock: always succeeds
  }
}
