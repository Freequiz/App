import 'package:flutter/material.dart';
import 'package:freequiz/controllers/quiz/learning.dart';
import 'package:freequiz/controllers/quiz/question.dart';
import 'package:freequiz/controllers/quiz/questionnaire.dart';

class MultipleChoiceController extends ChangeNotifier {
  List answerRight = List.filled(4, false);

  void rightAnswer(BuildContext context, int i) {
    answerRight[i] = true;
    notifyListeners();

    Future.delayed(const Duration(milliseconds: 300), () {
      if (!Learning.answeredWrong) {
        Questionnaire.answeredRight();
      }
      if (Questionnaire.questions.length > 1) {
        Learning.answeredWrong = false;
        Questionnaire.next();
        Question.randomChoices();
        notifyListeners();
      } else {
        if (context.mounted) Navigator.of(context).pop();
      }
      answerRight = List.filled(4, false);
    });
  }

  void wrongAnswer(BuildContext context, String choice, int i) {
    Learning().wrongAnswerMultipleChoice(context, choice, rightAnswer, i);
  }
}