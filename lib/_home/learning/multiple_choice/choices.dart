import 'package:flutter/material.dart';
import 'package:freequiz/others/device_info.dart';
import 'package:freequiz/quiz/questionnaire.dart';

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
      width: DeviceInfo().width() / 2.5,
      height: DeviceInfo().height() / 12,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: answerRight ? Colors.green : background,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        ),
        onPressed: () {
          if (choice != Questionnaire.questions[0].translation) {
            wrongAnswer(choice, i);
          } else {
            rightAnswer(i);
          }
        },
        child: Text(
          choice,
          style: TextStyle(
            color: color,
            fontSize: DeviceInfo().height() / 70,
          ),
        ),
      ),
    );
  }
}
