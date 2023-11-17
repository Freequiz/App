import 'package:flutter/material.dart';
import 'package:freequiz/_home/learning/multiple_choice/choices.dart';
import 'package:freequiz/_home/subviews/progress_bar.dart';
import 'package:freequiz/quiz.dart';
import 'package:freequiz/others/device_info.dart';

import '../../../others/utilities.dart';

class MultipleChoiceBody extends StatelessWidget {
  final List choices;
  final Function wrongAnswer;
  final Function rightAnswer;
  final List answerRight;
  final Color color;
  final Color background;
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
        Padding(
          padding: const EdgeInsets.only(top: 1.0),
          child: ProgressBar(
            amount: Quiz.amountDefinitions,
            amountLeft: Quiz.indexArray.length,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  Quiz.definition[Quiz.indexArray[0]],
                  style: textSize(DeviceInfo().height() / 16),
                ),
                SizedBox(
                  height: DeviceInfo().height() / 3,
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
                      background: background,
                      color: color,
                    ),
                    Choices(
                      choice: choices[1],
                      wrongAnswer: wrongAnswer,
                      rightAnswer: rightAnswer,
                      answerRight: answerRight[1],
                      i: 1,
                      background: background,
                      color: color,
                    ),
                  ],
                ),
                Space.height(DeviceInfo().height() / 100),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Choices(
                      choice: choices[2],
                      wrongAnswer: wrongAnswer,
                      rightAnswer: rightAnswer,
                      answerRight: answerRight[2],
                      i: 2,
                      background: background,
                      color: color,
                    ),
                    Choices(
                      choice: choices[3],
                      wrongAnswer: wrongAnswer,
                      rightAnswer: rightAnswer,
                      answerRight: answerRight[3],
                      i: 3,
                      background: background,
                      color: color,
                    ),
                  ],
                ),
                Space.height(DeviceInfo().height() / 16),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
