import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/route_names.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/utils/extensions/context_extensions.dart';
import '../../../../shared/models/psychometric_question.dart';
import '../../../../shared/widgets/buttons/primary_button.dart';
import '../../../../shared/widgets/indicators/progress_bar.dart';
import '../../bloc/onboarding_bloc.dart';
import '../widgets/answer_option_tile.dart';
import '../widgets/question_card.dart';
import '../widgets/slider_answer.dart';
import '../widgets/text_answer_field.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({super.key});

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  final _pageController = PageController();
  final Map<String, TextEditingController> _textControllers = {};

  @override
  void initState() {
    super.initState();
    context.read<OnboardingBloc>().add(const OnboardingStarted());
  }

  @override
  void dispose() {
    _pageController.dispose();
    for (final c in _textControllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  TextEditingController _textControllerFor(
    String questionId,
    OnboardingInProgress state,
  ) {
    return _textControllers.putIfAbsent(
      questionId,
      () {
        final answer = state.answerFor(questionId);
        final controller = TextEditingController(
          text: answer.freeText ?? '',
        );
        controller.addListener(() {
          context.read<OnboardingBloc>().add(AnswerUpdated(
                questionId: questionId,
                freeText: controller.text,
              ));
        });
        return controller;
      },
    );
  }

  void _handleNext(OnboardingInProgress state) {
    if (state.isLastQuestion) {
      context.read<OnboardingBloc>().add(const OnboardingCompleted());
    } else {
      context
          .read<OnboardingBloc>()
          .add(const QuestionNavigated(NavigationDirection.forward));
    }
  }

  void _handleBack() {
    context
        .read<OnboardingBloc>()
        .add(const QuestionNavigated(NavigationDirection.backward));
  }

  void _selectSingle(String questionId, String option) {
    context.read<OnboardingBloc>().add(AnswerUpdated(
          questionId: questionId,
          selectedOption: option,
        ));
  }

  void _toggleMulti(
    String questionId,
    String option,
    OnboardingInProgress state,
  ) {
    final current = List<String>.from(
      state.answerFor(questionId).selectedOptions,
    );
    if (current.contains(option)) {
      current.remove(option);
    } else {
      current.add(option);
    }
    context.read<OnboardingBloc>().add(AnswerUpdated(
          questionId: questionId,
          selectedOptions: current,
        ));
  }

  void _setSlider(String questionId, double value) {
    context.read<OnboardingBloc>().add(AnswerUpdated(
          questionId: questionId,
          sliderValue: value,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OnboardingBloc, OnboardingState>(
      listenWhen: (previous, current) {
        // Animate page only when currentIndex changes
        if (previous is OnboardingInProgress &&
            current is OnboardingInProgress) {
          return previous.currentIndex != current.currentIndex;
        }
        // Also listen for completion / error
        return current is OnboardingComplete || current is OnboardingError;
      },
      listener: (context, state) {
        if (state is OnboardingInProgress) {
          _pageController.animateToPage(
            state.currentIndex,
            duration:
                const Duration(milliseconds: AppDimensions.animNormal),
            curve: Curves.easeInOut,
          );
        } else if (state is OnboardingComplete) {
          context.goNamed(RouteNames.onboardingComplete);
        } else if (state is OnboardingError) {
          context.showSnackBar(state.message);
        }
      },
      builder: (context, state) {
        if (state is! OnboardingInProgress) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final questions = state.questions;
        final currentIndex = state.currentIndex;
        final progress = state.progress;

        return Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                // Top bar: back + progress
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimensions.spacing16,
                    vertical: AppDimensions.spacing12,
                  ),
                  child: Row(
                    children: [
                      if (currentIndex > 0)
                        IconButton(
                          onPressed: _handleBack,
                          icon: const Icon(Icons.arrow_back),
                          tooltip: 'Previous question',
                        )
                      else
                        const SizedBox(width: AppDimensions.minTapTarget),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppDimensions.spacing12,
                          ),
                          child: ProgressBar(progress: progress),
                        ),
                      ),
                      Text(
                        '${currentIndex + 1}/${questions.length}',
                        style: context.textTheme.labelMedium?.copyWith(
                          color: context.appColors.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                // Question pages
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: questions.length,
                    itemBuilder: (context, index) {
                      final question = questions[index];
                      return SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppDimensions.spacing24,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: AppDimensions.spacing16),
                            QuestionCard(question: question),
                            const SizedBox(height: AppDimensions.spacing24),
                            _buildAnswerWidget(question, state),
                            const SizedBox(height: AppDimensions.spacing32),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                // Next button
                Padding(
                  padding: const EdgeInsets.all(AppDimensions.spacing24),
                  child: PrimaryButton(
                    label: state.isLastQuestion ? 'Complete' : 'Next',
                    onPressed:
                        state.isCurrentAnswered ? () => _handleNext(state) : null,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildAnswerWidget(
    PsychometricQuestion question,
    OnboardingInProgress state,
  ) {
    final answer = state.answerFor(question.id);

    switch (question.type) {
      case QuestionType.singleChoice:
        return Column(
          children: question.options.map((option) {
            return AnswerOptionTile(
              text: option,
              isSelected: answer.selectedOption == option,
              onTap: () => _selectSingle(question.id, option),
            );
          }).toList(),
        );

      case QuestionType.multiChoice:
        return Column(
          children: question.options.map((option) {
            return AnswerOptionTile(
              text: option,
              isSelected: answer.selectedOptions.contains(option),
              onTap: () => _toggleMulti(question.id, option, state),
            );
          }).toList(),
        );

      case QuestionType.slider:
        return SliderAnswer(
          value: answer.sliderValue ?? question.sliderMin,
          min: question.sliderMin,
          max: question.sliderMax,
          minLabel: question.sliderMinLabel,
          maxLabel: question.sliderMaxLabel,
          onChanged: (v) => _setSlider(question.id, v),
        );

      case QuestionType.freeText:
        return TextAnswerField(
          controller: _textControllerFor(question.id, state),
        );
    }
  }
}
