import 'package:flutter/material.dart';
import 'package:freequiz/_home/learning_page/start_learning.dart';
import 'package:freequiz/quiz/quiz_helper.dart';


loadLearning(BuildContext context, String uuid, int i, Function reset, Function refresh) {
  if (QuizHelper.quiz!.translations.translations.isEmpty) return;

  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (BuildContext context) {
        return StartLearning(i: i, uuid: uuid, refresh: refresh,);
      },
    ),
  );
}
