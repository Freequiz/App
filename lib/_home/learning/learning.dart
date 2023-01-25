import 'dart:math';

import 'package:flutter/material.dart';
import 'package:freequiz/_home/subviews/correction.dart';
import 'package:freequiz/quiz.dart';

class Learning {
  static List<String> choices = [];
  static bool answeredWrong = false;
  static bool showAnswer = false;

  randomChoices() {
    List<String> copyArray = Quiz.answer.toList();
    choices = [];
    copyArray.removeAt(Quiz.indexArray[0]);
    for (var n = 0; n < 3; n++) {
      if (copyArray.isNotEmpty) {
        int i = Random().nextInt(copyArray.length);
        choices.add(copyArray[i]);
        copyArray.removeAt(i);
      } else {
        choices.add('');
      }
    }
    int i = Random().nextInt(4);
    choices.insert(i, Quiz.answer[Quiz.indexArray[0]]);
    return choices;
  }

  newChoices() {
    choices = randomChoices();
  }

  correct(String input) {
    if (input
            .trim()
            .replaceAll(',', ' ')
            .replaceAll('/', ' ')
            .replaceAll('.', ' ')
            .replaceAll(';', ' ')
            .replaceAll('(', ' ')
            .replaceAll(')', ' ')
            .replaceAll('.', ' ')
            .replaceAll('   ', '')
            .replaceAll('  ', '') ==
        Quiz.answer[Quiz.indexArray[0]]
            .replaceAll(',', ' ')
            .replaceAll('/', ' ')
            .replaceAll('.', ' ')
            .replaceAll(';', ' ')
            .replaceAll('(', ' ')
            .replaceAll(')', ' ')
            .replaceAll('   ', '')
            .replaceAll('  ', '')) {
      return true;
    }
    return false;
  }

  wrongAnswerWriting(TextEditingController textController, BuildContext context,
      Function rightAnswerW) {
    final givenAnswer = textController.text;
    showDialog(
      context: context,
      builder: (BuildContext context) => Correction(
        givenAnswer: givenAnswer,
        rightAnswer: Quiz.answer[Quiz.indexArray[0]],
      ),
    ).then((answerRight) {
      if (answerRight != null) {
        if (answerRight) {
          rightAnswerW();
        } else {
          answeredWrong = true;
          Quiz().answeredWrong();
        }
      } else {
        answeredWrong = true;
        Quiz().answeredWrong();
      }
    });
    textController.clear();
  }

  wrongAnswerMultipleChoice(
      BuildContext context, String choice, Function rightAnswerMC, int i) {
    showDialog(
      context: context,
      builder: (BuildContext context) => Correction(
        givenAnswer: choice,
        rightAnswer: Quiz.answer[Quiz.indexArray[0]],
      ),
    ).then((answerRight) {
      if (answerRight != null) {
        if (answerRight) {
          rightAnswerMC(i);
        } else {
          answeredWrong = true;
          Quiz().answeredWrong();
        }
      } else {
        answeredWrong = true;
        Quiz().answeredWrong();
      }
    });
  }

  int indexMode() {
    if (Quiz.progressArray[0].contains(Quiz.indexArray[0])) {
      return 0;
    }
    return 1;
  }

  close(BuildContext context, Function refresh, String uuid, String mode) {
    FocusScope.of(context).requestFocus(FocusNode());
    Quiz().saveData(mode, uuid);
    Future.delayed(const Duration(milliseconds: 500), () {
      refresh();
      Navigator.of(context).pop();
    });
  }
}
