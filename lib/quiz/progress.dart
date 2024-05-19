import 'package:freequiz/api/quizzes.dart';
import 'package:freequiz/local_storage/quizzes.dart';
import 'package:freequiz/models/translation.dart';
import 'package:freequiz/quiz.dart';

class Progress {
  static int amount = 0;

  static reset(String mode, String uuid) {
    for (Translation translation in QuizHelper.quiz!.translations.translations) {
      translation.score[mode] = 0;
    }
    
    LocalStorage.saveQuiz(uuid, QuizHelper.quiz!.toMap());
    APIQuizzes.resetScore(uuid, mode);
  }

  static increase(String uuid, String mode, Translation translation) {
    translation.score[mode] = translation.score[mode]! - 1;

    if (translation.score[mode]! < 0) {
      translation.score[mode] = 0;
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

  static calculate(int mode) {
    amount = 0;
    for (Translation translation in QuizHelper.quiz!.translations.translations) {
      amount += translation.score[mode]! as int;
    }
  }

  static List<Translation> array(int mode, int score) {
    List<Translation> array = [];
    for (Translation translation in QuizHelper.quiz!.translations.translations) {
      if (translation.score[mode] == score) {
        array.add(translation);
      }
    }
    return array;
  }
}