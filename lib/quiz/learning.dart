import 'package:flutter/material.dart';
import 'package:freequiz/local_storage/quizzes.dart';
import 'package:freequiz/quiz/quiz_helper.dart';
import 'package:freequiz/quiz/questionnaire.dart';
import 'package:freequiz/_views/learning/correction.dart';

class Learning {
  static final modes = [
    'smart',
    'write',
    'multi',
    'cards'
  ];

  static bool answeredWrong = false;
  static bool showAnswer = false;

  wrongAnswerWriting(TextEditingController textController, BuildContext context, Function rightAnswerW) {
    final givenAnswer = textController.text;

    showDialog(
      context: context,
      builder: (BuildContext context) => Correction(
        givenAnswer: givenAnswer,
        rightAnswer: Questionnaire.questions[0].translation,
      ),
    ).then((answerRight) {
      if (answerRight != null) {
        if (answerRight) {
          rightAnswerW();
        } else {
          answeredWrong = true;
          Questionnaire.answeredWrong();
        }
      } else {
        answeredWrong = true;
        Questionnaire.answeredWrong();
      }
    });
    textController.clear();
  }

  wrongAnswerMultipleChoice(BuildContext context, String choice, Function rightAnswerMC, int i) {
    showDialog(
      context: context,
      builder: (BuildContext context) => Correction(
        givenAnswer: choice,
        rightAnswer: Questionnaire.questions[0].translation,
      ),
    ).then((answerRight) {
      if (answerRight != null) {
        if (answerRight) {
          rightAnswerMC(i);
        } else {
          answeredWrong = true;
          Questionnaire.answeredWrong();
        }
      } else {
        answeredWrong = true;
        Questionnaire.answeredWrong();
      }
    });
  }

  /*int indexMode() {
    if (QuizHelper.progressArray[0].contains(QuizHelper.indexArray[0])) {
      return 0;
    }
    return 1;
  }*/

  static stop(BuildContext context, Function refresh, String uuid, String mode) {
    LocalStorage.saveQuiz(uuid, QuizHelper.quiz!.toMap());
    FocusScope.of(context).requestFocus(FocusNode());
    Future.delayed(const Duration(milliseconds: 500), () {
      refresh();
      Navigator.of(context).pop();
    });
  }
}
