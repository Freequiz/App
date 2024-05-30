import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:freequiz/_home/quiz_page/title.dart';
import 'package:freequiz/loading/load_user.dart';
import 'package:freequiz/others/device_info.dart';
import 'package:freequiz/others/style.dart';
import 'package:freequiz/quiz/quiz_helper.dart';

class QuizDescription extends StatelessWidget {
  const QuizDescription({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: DeviceInfo.darkMode ? gray60 : white235,
        borderRadius: BorderRadius.circular(DeviceInfo().width() / 30.4),
      ),
      constraints: BoxConstraints(minHeight: DeviceInfo().height() / 15),
      child: Column(
        children: [
          const QuizTitle(),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 13.0, vertical: 10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: (DeviceInfo().width() - 46) / 8 * 7,
                  child: Text(
                    QuizHelper.quiz!.description != ""
                        ? QuizHelper.quiz!.description!
                        : context.tr('no description'),
                    style: TextStyle(
                        fontSize: DeviceInfo.mobileLayout
                            ? DeviceInfo().height() / 55
                            : DeviceInfo().height() / 45),
                  ),
                ),
                GestureDetector(
                  onTap: () => loadUser(
                      context: context, user: QuizHelper.quiz!.creator),
                  child: Container(
                    height: DeviceInfo().height() / 35,
                    width: DeviceInfo().height() / 35,
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(DeviceInfo().height() / 70),
                      border: Border.all(color: Colors.white, width: 2.0),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.person,
                        size: DeviceInfo().height() / 45,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
