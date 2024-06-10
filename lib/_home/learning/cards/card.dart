import 'package:flutter/material.dart';
import 'package:freequiz/quiz/learning.dart';
import 'package:freequiz/others/device_info.dart';
import 'package:freequiz/others/style.dart';
import 'package:freequiz/quiz/questionnaire.dart';
import 'package:freequiz/utilities/extensions/context_extensions.dart';

class CardWidget extends StatelessWidget {
  CardWidget({super.key});

  final backgroundColor = DeviceInfo.darkMode
      ? const Color.fromARGB(255, 50, 50, 50)
      : const Color.fromARGB(255, 246, 246, 246);
  final foregroundColor = DeviceInfo.darkMode ? Colors.white : gray40;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.screenWidth / 1.25,
      height: DeviceInfo.mobileLayout
          ? context.screenHeight/ 4
          : context.screenWidth / 2.5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(context.screenHeight/ 20),
        color: backgroundColor,
      ),
      alignment: Alignment.center,
      child: Text(
        Learning.showAnswer
            ? Questionnaire.answer()
            : Questionnaire.definition(),
        style: TextStyle(
            fontSize: context.screenHeight/ 24, color: foregroundColor),
      ),
    );
  }
}
