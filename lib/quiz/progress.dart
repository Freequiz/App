import 'package:freequiz/api/quizzes.dart';
import 'package:freequiz/local_storage/database.dart';
import 'package:freequiz/models/translation.dart';
import 'package:freequiz/quiz/quiz_helper.dart';
import 'package:freequiz/quiz/questionnaire.dart';

class Progress {
  static double amount = 0;

  static reset(String mode, String uuid) {
    for (Translation translation in QuizHelper.quiz!.translations.translations) {
      translation.score[mode] = 0;
    }
    
    QuizDatabase.updateQuiz(QuizHelper.quiz!);
    APIQuizzes.resetScore(uuid, mode);
  }

  static increase(String uuid, String mode, Translation translation) {
    translation.score[mode] = translation.score[mode]! + 1;

    if (translation.score[mode]! > Questionnaire.maxScore(mode)) {
      translation.score[mode] = Questionnaire.maxScore(mode);
    }


    APIQuizzes.setScore(uuid, translation.scoreID, mode, translation.score[mode]!);
  }

  static decrease(String uuid, String mode, Translation translation) {
    translation.score[mode] = translation.score[mode]! - 1;

    if (translation.score[mode]! < 0) {
      translation.score[mode] = 0;
    }

    APIQuizzes.setScore(uuid, translation.scoreID, mode, translation.score[mode]!);
  }

  static calculate(String mode) {
    amount = 0;
    for (Translation translation in QuizHelper.quiz!.translations.translations) {
      amount += translation.score[mode]! as int;
    }
    amount = amount / Questionnaire.maxScore(mode);
  }

  static List<Translation> array(String mode, int score) {
    List<Translation> array = [];
    for (Translation translation in QuizHelper.quiz!.translations.translations) {
      if (translation.score[mode] == score) {
        array.add(translation);
      }
    }
    return array;
  }
}