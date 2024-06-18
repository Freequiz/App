import 'dart:math';

import 'package:freequiz/local_storage/preferences.dart';
import 'package:freequiz/models/translation.dart';
import 'package:freequiz/quiz/learning.dart';
import 'package:freequiz/quiz/quiz_helper.dart';
import 'package:freequiz/quiz/progress.dart';
import 'package:freequiz/user/helper.dart';

class Questionnaire {
  static List<Translation> questions = [];
  static int length = 0;

  static String mode = "";

  static create(bool onlyFavorite, String quizMode) {
    questions.clear();
    mode = quizMode;

    List<Translation> options = [];

    for (Translation translation in QuizHelper.quiz!.translations.translations) {
      if (onlyFavorite && !translation.favorite) continue;

      if (translation.score[mode]! >= Questionnaire.maxScore(mode)) continue;

      options.add(translation);
    }

    if (options.isEmpty) {
      for (Translation translation in QuizHelper.quiz!.translations.translations) {
        if (onlyFavorite && !translation.favorite) continue;

        options.add(translation);
      }
    }

    randomise(options);
    
    Learning.errors.clear();
    length = questions.length;    
  }

  static randomise(List<Translation> array) {
    if (Learning.errors.length < Questionnaire.desiredLength()) {
      for (var n = 0; n < Questionnaire.desiredLength() - Learning.errors.length; n++) {
        if (array.isEmpty) break;

        final i = Random().nextInt(array.length);
        questions.add(array[i]);
        array.removeAt(i);
      }
    }

    //add previous errors
    for (Translation translation in Learning.errors) {
      if (questions.contains(translation)) return;
      final i = questions.isNotEmpty ? Random().nextInt(questions.length) : 0;
      questions.insert(i, translation);
    }
  }

  static answeredWrong() {
    Progress.decrease(QuizHelper.quiz!.id, mode, questions[0]);
    if (Learning.errors.contains(questions[0])) return;
    Learning.errors.add(questions[0]);
  }

  static answeredRight() {
    Progress.increase(QuizHelper.quiz!.id, mode, questions[0]);
  }

  static maxScore(String mode) {
    return UserHelper.user?.settings.maxScore(mode) ?? 2;
  }

  static desiredLength() {
    return UserHelper.user?.settings.lengthQuestionnaire;
  }

  static definition() {
    if (Preferences.answerLanguage == 0) {
      return questions[0].translation;
    }
    return questions[0].word;
  }

  static answer() {
    if (Preferences.answerLanguage == 0) {
      return questions[0].word;
    }
    return questions[0].translation;
  }
}