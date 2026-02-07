import 'package:equatable/equatable.dart';

class PsychometricAnswer extends Equatable {
  const PsychometricAnswer({
    required this.questionId,
    this.selectedOption,
    this.selectedOptions = const [],
    this.sliderValue,
    this.freeText,
  });

  final String questionId;

  /// For [QuestionType.singleChoice].
  final String? selectedOption;

  /// For [QuestionType.multiChoice].
  final List<String> selectedOptions;

  /// For [QuestionType.slider].
  final double? sliderValue;

  /// For [QuestionType.freeText].
  final String? freeText;

  bool get isAnswered =>
      selectedOption != null ||
      selectedOptions.isNotEmpty ||
      sliderValue != null ||
      (freeText != null && freeText!.trim().isNotEmpty);

  PsychometricAnswer copyWith({
    String? questionId,
    String? selectedOption,
    List<String>? selectedOptions,
    double? sliderValue,
    String? freeText,
  }) {
    return PsychometricAnswer(
      questionId: questionId ?? this.questionId,
      selectedOption: selectedOption ?? this.selectedOption,
      selectedOptions: selectedOptions ?? this.selectedOptions,
      sliderValue: sliderValue ?? this.sliderValue,
      freeText: freeText ?? this.freeText,
    );
  }

  @override
  List<Object?> get props => [
        questionId,
        selectedOption,
        selectedOptions,
        sliderValue,
        freeText,
      ];
}
