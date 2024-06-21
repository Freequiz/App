import 'package:freequiz/_home/learning/multiple_choice/choices.dart';
import 'package:freequiz/_home/learning/prompt.dart';
import 'package:freequiz/_views/progress_bar.dart';
import 'package:freequiz/quiz/questionnaire.dart';
import 'package:freequiz/utilities/imports/utilities.dart';

class MultipleChoiceBody extends StatelessWidget {
  final List choices;
  final Function wrongAnswer;
  final Function rightAnswer;
  final List answerRight;
  final Color color;
  final ColorFamily background;
  const MultipleChoiceBody(
      {super.key,
      required this.choices,
      required this.wrongAnswer,
      required this.rightAnswer,
      required this.answerRight,
      required this.color,
      required this.background});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ProgressBar(
          amount: Questionnaire.length,
          amountLeft: Questionnaire.questions.length.toDouble(),
          color: background
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextPromt(text: Questionnaire.definition()),
                SizedBox(
                  height: context.screenHeight/ 3,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Choices(
                      choice: choices[0],
                      wrongAnswer: wrongAnswer,
                      rightAnswer: rightAnswer,
                      answerRight: answerRight[0],
                      i: 0,
                      background: background.light,
                      color: color,
                    ),
                    Choices(
                      choice: choices[1],
                      wrongAnswer: wrongAnswer,
                      rightAnswer: rightAnswer,
                      answerRight: answerRight[1],
                      i: 1,
                      background: background.light,
                      color: color,
                    ),
                  ],
                ),
                Space.height(context.screenHeight/ 100),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Choices(
                      choice: choices[2],
                      wrongAnswer: wrongAnswer,
                      rightAnswer: rightAnswer,
                      answerRight: answerRight[2],
                      i: 2,
                      background: background.light,
                      color: color,
                    ),
                    Choices(
                      choice: choices[3],
                      wrongAnswer: wrongAnswer,
                      rightAnswer: rightAnswer,
                      answerRight: answerRight[3],
                      i: 3,
                      background: background.light,
                      color: color,
                    ),
                  ],
                ),
                Space.height(context.screenHeight/ 16),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
