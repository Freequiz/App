import 'dart:math';

import 'package:flutter/material.dart';
import 'package:freequiz/1_edit/quiz_draft/draft.dart';
import 'package:freequiz/1_edit/edit_create_quiz/create_quiz.dart';
import 'package:freequiz/1_edit/created_quizzes/created_quizzes.dart';
import 'package:freequiz/others/utilities.dart';
import 'package:freequiz/quiz/quiz_helper.dart';
import 'package:freequiz/others/device_info.dart';
import 'package:freequiz/others/initial_loading.dart';
import 'package:freequiz/others/style.dart';

class EditOverview extends StatefulWidget {
  final List data;
  const EditOverview({super.key, required this.data});

  @override
  State<EditOverview> createState() => _EditOverviewState();
}

class _EditOverviewState extends State<EditOverview> {
  bool draft = false;
  Key key = Key(Random().toString());

  refresh() {
    setState(() {
      key = Key(Random().toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: DeviceInfo.mobileLayout
          ? const EdgeInsets.all(10.0)
          : const EdgeInsets.all(30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Center(
            child: TextButton(
              style: TextButton.styleFrom(
                  backgroundColor: grayFreequiz, foregroundColor: Colors.white),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return CreateQuiz(
                        refresh: refresh,
                      );
                    },
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  language["Create a New Quiz"],
                  style: textSize(DeviceInfo().height() / 45),
                ),
              ),
            ),
          ),
          Space.height(DeviceInfo.mobileLayout ? 15 : 45),
          conditional(
            QuizHelper.draft.isNotEmpty,
            Draft(
              refresh: refresh,
            ),
          ),
          Expanded(
            child: CreatedQuizzes(
              key: key,
              refresh: refresh,
            ),
          ),
        ],
      ),
    );
  }
}
