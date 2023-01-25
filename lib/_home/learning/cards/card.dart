import 'package:flutter/material.dart';
import 'package:freequiz/_home/learning/learning.dart';
import 'package:freequiz/others/device_info.dart';
import 'package:freequiz/others/style.dart';
import 'package:freequiz/quiz.dart';

class CardWidget extends StatelessWidget {
  CardWidget({super.key});

  final backgroundColor = DeviceInfo.darkMode
      ? const Color.fromARGB(255, 50, 50, 50)
      : const Color.fromARGB(255, 246, 246, 246);
  final foregroundColor = DeviceInfo.darkMode ? Colors.white : textGray;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: DeviceInfo().width() / 1.25,
      height: DeviceInfo.mobileLayout
          ? DeviceInfo().height() / 4
          : DeviceInfo().width() / 2.5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(DeviceInfo().height() / 20),
        color: backgroundColor,
      ),
      alignment: Alignment.center,
      child: Text(
        Learning.showAnswer
            ? Quiz.answer[Quiz.indexArray[0]]
            : Quiz.definition[Quiz.indexArray[0]],
        style: TextStyle(
            fontSize: DeviceInfo().height() / 24, color: foregroundColor),
      ),
    );
  }
}
