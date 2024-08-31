import 'package:flutter/material.dart';
import 'package:freequiz/_views/_home/learning_page/start_learning.dart';
import 'package:freequiz/controllers/quiz/quiz_helper.dart';


loadLearning(BuildContext context, int i, Function refresh) {
  if (QuizHelper.quiz!.translations.translations.isEmpty) return;

  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (BuildContext context) {
        return StartLearning(i: i, uuid: QuizHelper.quiz!.id, refresh: refresh,);
      },
    ),
  );
}
