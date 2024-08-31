import 'package:freequiz/_views/_home/learning/multiple_choice/choices.dart';
import 'package:freequiz/_views/_home/learning/prompt.dart';
import 'package:freequiz/_views/subviews/progress_bar.dart';
import 'package:freequiz/controllers/quiz/questionnaire.dart';
import 'package:freequiz/utilities/imports/utilities.dart';

class MultipleChoiceBody extends StatelessWidget {
  final List choices;
  final Function wrongAnswer;
  final Function rightAnswer;
  final List answerRight;
  final ColorFamily color;
  const MultipleChoiceBody(
      {super.key,
      required this.choices,
      required this.wrongAnswer,
      required this.rightAnswer,
      required this.answerRight,
      required this.color});

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
              wrongAnswer: wrongAnswer,
              rightAnswer: rightAnswer,
              answerRight: answerRight[0],
              i: 0,
              color: color,
            ),
            Space.width(10),
            Choices(
              choice: choices[1],
              wrongAnswer: wrongAnswer,
              rightAnswer: rightAnswer,
              answerRight: answerRight[1],
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
              choice: choices[2],
              wrongAnswer: wrongAnswer,
              rightAnswer: rightAnswer,
              answerRight: answerRight[2],
              i: 2,
              color: color,
            ),
            Space.width(10),
            Choices(
              choice: choices[3],
              wrongAnswer: wrongAnswer,
              rightAnswer: rightAnswer,
              answerRight: answerRight[3],
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
