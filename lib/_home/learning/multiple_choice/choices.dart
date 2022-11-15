import 'package:flutter/material.dart';
import 'package:freequiz/_home/quiz.dart';

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
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width / 2.5,
      height: height / 12,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: answerRight ? Colors.green : background,
        ),
        onPressed: () {
          if (choice != Quiz.answer[Quiz.indexArray[0]]) {
            wrongAnswer(choice);
          } else {
            rightAnswer(i);
          }
        },
        child: Text(
          choice,
          style: TextStyle(
            color: color,
            fontSize: height / 70,
          ),
        ),
      ),
    );
  }
}
