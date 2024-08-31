import 'package:freequiz/services/api/quizzes.dart';
import 'package:freequiz/services/local_storage/database.dart';
import 'package:freequiz/models/translation.dart';
import 'package:freequiz/controllers/quiz/quiz_helper.dart';
import 'package:freequiz/controllers/quiz/questionnaire.dart';

class Progress {
  static double amount = 0;

  static reset(String mode, String uuid) {
    for (Translation translation in QuizHelper.quiz!.translations.translations) {
      translation.score[mode] = 0;
      translation.updated = DateTime.now().millisecondsSinceEpoch;
    }
    
    QuizDatabase.updateQuiz(QuizHelper.quiz!);
    APIQuizzes.resetScore(uuid, mode);
  }

  static increase(String uuid, String mode, Translation translation) {
    int score = translation.score[mode]! + 1;

    if (score > Questionnaire.maxScore(mode)) {
      score = Questionnaire.maxScore(mode);
    }

    translation.setScore(uuid, mode, score);
  }

  static decrease(String uuid, String mode, Translation translation) {
    int score = translation.score[mode]! - 1;

    if (score < 0) {
      score = 0;
    }

    translation.setScore(uuid, mode, score);
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