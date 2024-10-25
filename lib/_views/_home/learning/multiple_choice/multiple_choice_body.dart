import 'package:freequiz/_views/_home/learning/multiple_choice/choices.dart';
import 'package:freequiz/_views/_home/learning/prompt.dart';
import 'package:freequiz/_views/subviews/progress_bar.dart';
import 'package:freequiz/controllers/home/learning/learning.dart';
import 'package:freequiz/controllers/quiz/questionnaire.dart';
import 'package:freequiz/utilities/imports/utilities.dart';

class MultipleChoiceBody<T> extends StatelessWidget {
  final List choices;
  final ColorFamily color;
  final BaseLearningController controller;
  const MultipleChoiceBody({
    super.key,
    required this.choices,
    required this.color,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ProgressBar(amount: Questionnaire.length, amountLeft: Questionnaire.questions.length.toDouble(), color: color),
        Space.height(20.0),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: TextPromt(text: Questionnaire.definition()),
        ),
        const Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Choices(
              choice: choices[0],
              i: 0,
              color: color,
              controller: controller,
            ),
            Space.width(10),
            Choices(
              choice: choices[1],
              i: 1,
              color: color,
              controller: controller,
            ),
          ],
        ),
        Space.height(10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Choices(
              choice: choices[2],
              i: 2,
              color: color,
              controller: controller,
            ),
            Space.width(10),
            Choices(
              choice: choices[3],
              i: 3,
              color: color,
              controller: controller,
            ),
          ],
        ),
        Space.height(context.screenHeight / 16),
      ],
    );
  }
}
