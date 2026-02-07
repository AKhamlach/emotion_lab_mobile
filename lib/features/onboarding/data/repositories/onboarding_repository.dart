import '../../../../shared/models/psychometric_answer.dart';
import '../../../../shared/models/psychometric_question.dart';

/// Abstract contract for onboarding operations.
abstract class OnboardingRepository {
  Future<List<PsychometricQuestion>> getQuestions();

  Future<void> submitAnswers(Map<String, PsychometricAnswer> answers);
}
