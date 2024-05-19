import 'dart:math';

import 'package:freequiz/models/translation.dart';
import 'package:freequiz/quiz.dart';
import 'package:freequiz/quiz/progress.dart';

class Questionnaire {
  static List<Translation> questions = [];
  static int length = 0;

  static int maxScore = 3;
  static String mode = "";

  static create(bool onlyFavorite, String quizMode) {
    questions.clear();
    mode = quizMode;

    List<Translation> array = [];

    for (Translation translation in QuizHelper.quiz!.translations.translations) {
      if (onlyFavorite && !translation.favorite) continue;

      if (translation.score[mode]! >= 3) continue;

      array.add(translation);
    }

    if (array.isEmpty) {
      for (Translation translation in QuizHelper.quiz!.translations.translations) {
        if (onlyFavorite && !translation.favorite) continue;

        array.add(translation);
      }
    }

    randomise(array);
    length = questions.length;
  }

  static randomise(List<Translation> array) {
    for (var _ = 0; _ < 20; _++) {
      if (array.isEmpty) break;

      final i = Random().nextInt(array.length);
      questions.add(array[i]);
      array.removeAt(i);
    }
  }

  static answeredWrong() {
    Progress.decrease(QuizHelper.quiz!.id, mode, questions[0]);
  }

  static answeredRight() {
    Progress.increase(QuizHelper.quiz!.id, mode, questions[0]);
  }
}