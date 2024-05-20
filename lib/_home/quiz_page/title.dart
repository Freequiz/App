import 'package:flutter/material.dart';
import 'package:freequiz/others/device_info.dart';
import 'package:freequiz/others/style.dart';
import 'package:freequiz/quiz/quiz_helper.dart';

class QuizTitle extends StatelessWidget {
  const QuizTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 13.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: grayFreequiz,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(DeviceInfo().width() / 30.4),
          topRight: Radius.circular(DeviceInfo().width() / 30.4),
        ),
      ),
      child: Text(
        QuizHelper.quiz!.title,
        style: TextStyle(
            fontSize: DeviceInfo().height() / 40,
            fontWeight: FontWeight.w600,
            color: Colors.white),
      ),
    );
  }
}
