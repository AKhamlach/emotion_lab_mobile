import 'package:equatable/equatable.dart';

enum QuestionCategory {
  personality,
  workHabit,
  stressTrigger,
}

enum QuestionType {
  singleChoice,
  multiChoice,
  slider,
  freeText,
}

class PsychometricQuestion extends Equatable {
  const PsychometricQuestion({
    required this.id,
    required this.text,
    required this.category,
    required this.type,
    this.options = const [],
    this.emoji,
    this.sliderMin = 1,
    this.sliderMax = 5,
    this.sliderMinLabel,
    this.sliderMaxLabel,
  });

  final String id;
  final String text;
  final QuestionCategory category;
  final QuestionType type;
  final List<String> options;
  final String? emoji;
  final double sliderMin;
  final double sliderMax;
  final String? sliderMinLabel;
  final String? sliderMaxLabel;

  String get categoryLabel {
    switch (category) {
      case QuestionCategory.personality:
        return 'Personality';
      case QuestionCategory.workHabit:
        return 'Work Habits';
      case QuestionCategory.stressTrigger:
        return 'Stress Triggers';
    }
  }

  @override
  List<Object?> get props => [
        id,
        text,
        category,
        type,
        options,
        emoji,
        sliderMin,
        sliderMax,
        sliderMinLabel,
        sliderMaxLabel,
      ];
}
