import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:freequiz/local_storage/database.dart';
import 'package:freequiz/models/translation.dart';
import 'package:freequiz/quiz/quiz_helper.dart';
import 'package:freequiz/quiz/questionnaire.dart';
import 'package:freequiz/_views/alerts/correction.dart';

class Learning {
  static final modes = ['smart', 'write', 'multi', 'cards'];

  static final List<String> levels = [
    "new".tr(),
    "memorized".tr(),
    "learned".tr(),
    "mastered".tr(),
  ];

  static final Map<String, List<String>> maxScoreOptions = {
    'smart': [],
    'write': ["1", "2", "3"],
    'multi': ["1", "2", "3"],
    'cards': ["1", "2"],
  };

  static bool answeredWrong = false;
  static bool showAnswer = false;

  static final List<Translation> errors = [];
  static String idQuiz = "";

  wrongAnswerWriting(TextEditingController textController, BuildContext context, Function rightAnswerW) {
    final givenAnswer = textController.text;

    showDialog(
      context: context,
      builder: (BuildContext context) => Correction(
        givenAnswer: givenAnswer,
        rightAnswer: Questionnaire.answer(),
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
        rightAnswer: Questionnaire.answer(),
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

  static stop(Function refresh, String uuid, String mode) {
    Learning.showAnswer = false;
    QuizDatabase.updateQuiz(QuizHelper.quiz!);
    refresh();
  }

  static List<String> getLevels(int i) {
    List<String> listLevels = [levels[0]];
    String mode = modes[i];

    for (int n = Questionnaire.maxScore(mode); n >= 1; n--) {
      if (n > levels.length) {
        listLevels.add(n.toString());
      }
      listLevels.add(levels[levels.length - n]);
    }

    return listLevels;
  }
}
