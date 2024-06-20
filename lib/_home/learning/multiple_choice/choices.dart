import 'package:freequiz/quiz/questionnaire.dart';
import 'package:freequiz/utilities/imports/base.dart';

class Choices extends StatelessWidget {
  final String choice;
  final Function wrongAnswer;
  final Function rightAnswer;
  final bool answerRight;
  final int i;
  final Color color;
  final Color background;
  const Choices({
    super.key,
    required this.choice,
    required this.wrongAnswer,
    required this.rightAnswer,
    required this.answerRight,
    required this.i,
    required this.color,
    required this.background,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.screenWidth / 2.5,
      height: context.screenHeight/ 12,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: answerRight ? Colors.green : background,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        ),
        onPressed: () {
          if (choice != Questionnaire.answer()) {
            wrongAnswer(choice, i);
          } else {
            rightAnswer(i);
          }
        },
        child: Text(
          choice,
          style: TextStyle(
            color: color,
            fontSize: context.screenHeight/ 70,
          ),
        ),
      ),
    );
  }
}
