import 'package:flutter/material.dart';
import 'package:freequiz/others/device_info.dart';
import 'package:freequiz/others/style.dart';
import 'package:freequiz/quiz.dart';

class QuizDescription extends StatelessWidget {
  const QuizDescription({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 13.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: DeviceInfo.darkMode ? gray60 : backgroundWhite,
        borderRadius: BorderRadius.circular(DeviceInfo().width() / 30.4),
      ),
      constraints: BoxConstraints(minHeight: DeviceInfo().height() / 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: (DeviceInfo().width() - 46) / 8 * 7,
            child: Text(
              Quiz.mapQuiz['quiz_data']['description'],
              style: TextStyle(
                  fontSize: DeviceInfo.mobileLayout
                      ? DeviceInfo().height() / 50
                      : DeviceInfo().height() / 45),
            ),
          ),
          Container(
            height: DeviceInfo().height() / 35,
            width: DeviceInfo().height() / 35,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(DeviceInfo().height() / 70),
              border: Border.all(color: Colors.white, width: 2.0),
            ),
            child: Center(
                child: Icon(
              Icons.person,
              size: DeviceInfo().height() / 45,
            )),
          ),
        ],
      ),
    );
  }
}
