import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:freequiz/_home/learning/prompt.dart';
import 'package:freequiz/_views/learning/progress_bar.dart';
import 'package:freequiz/others/device_info.dart';
import 'package:freequiz/quiz/questionnaire.dart';

import '../../../others/utilities.dart';

class WritingBody extends StatelessWidget {
  final Function onPressed;
  final bool answerRight;
  final TextEditingController textController;
  final Color color;
  const WritingBody({
    super.key,
    required this.onPressed,
    required this.answerRight,
    required this.textController,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 1.0),
          child: ProgressBar(
            amount: Questionnaire.length,
            amountLeft: Questionnaire.questions.length.toDouble(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
              top: 10.0, right: 10.0, left: 10.0, bottom: 10.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextPromt(text: Questionnaire.definition()),
                Space.height(DeviceInfo().height() / 5),
                Row(
                  children: [
                    Flexible(
                      child: SizedBox(
                        height: DeviceInfo.mobileLayout ? DeviceInfo().height() / 20 : DeviceInfo().height() / 30,
                        child: TextField(
                          autocorrect: false,
                          enableSuggestions: false,
                          keyboardType: TextInputType.text,
                          keyboardAppearance:
                              DeviceInfo.darkMode ? Brightness.dark : Brightness.light,
                          controller: textController,
                          onEditingComplete: () {
                            onPressed();
                          },
                          autofocus: true,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: color,
                                width: 2.0,
                              ),
                            ),
                            contentPadding: const EdgeInsets.all(10.0),
                            hintText: context.tr('translation'),
                            border: const OutlineInputBorder(),
                            suffixIcon: IconButton(
                              color: color,
                              onPressed: () {
                                textController.clear();
                              },
                              icon: const Icon(Icons.clear),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Space.width(5),
                    SizedBox(
                      height: DeviceInfo.mobileLayout ? DeviceInfo().height() / 20 : DeviceInfo().height() / 30,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: answerRight ? Colors.green : color,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () {
                          onPressed();
                        },
                        child: const Icon(Icons.arrow_forward_ios),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
