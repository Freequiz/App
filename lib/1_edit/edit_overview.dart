import 'package:flutter/material.dart';
import 'package:freequiz/1_edit/quiz_draft/draft.dart';
import 'package:freequiz/1_edit/edit_create_quiz/create_quiz.dart';
import 'package:freequiz/1_edit/created_quizzes/created_quizzes.dart';
import 'package:freequiz/quiz.dart';
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

  refresh() {
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Center(
            child: TextButton(
              style: TextButton.styleFrom(
                  backgroundColor: color1, foregroundColor: Colors.white),
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
                  style: TextStyle(fontSize: DeviceInfo().height() / 45),
                ),
              ),
            ),
          ),
          SizedBox(
            height: DeviceInfo.mobileLayout ? 15 : 45,
          ),
          Quiz.draft.isNotEmpty
              ? Draft(
                  refresh: refresh,
                )
              : const SizedBox(
                  height: 0,
                ),
          Expanded(
            child: CreatedQuizzes(
              refresh: refresh,
            ),
          ),
        ],
      ),
    );
  }
}
