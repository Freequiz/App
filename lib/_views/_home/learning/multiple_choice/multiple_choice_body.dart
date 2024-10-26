import 'package:freequiz/_views/_home/learning/multiple_choice/choices.dart';
import 'package:freequiz/_views/_home/learning/prompt.dart';
import 'package:freequiz/_views/subviews/progress_bar.dart';
import 'package:freequiz/controllers/quiz/questionnaire.dart';
import 'package:freequiz/utilities/imports/utilities.dart';

class MultipleChoiceBody<T> extends StatelessWidget {
  final ColorFamily color;
  const MultipleChoiceBody({
    super.key,
    required this.color,
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
              i: 0,
              color: color,
            ),
            Space.width(10),
            Choices(
              i: 1,
              color: color,
            ),
          ],
        ),
        Space.height(10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Choices(
              i: 2,
              color: color,
            ),
            Space.width(10),
            Choices(
              i: 3,
              color: color,
            ),
          ],
        ),
        Space.height(context.screenHeight / 16),
      ],
    );
  }
}
