import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:freequiz/api/quizzes.dart';
import 'package:freequiz/local_storage/database.dart';
import 'package:freequiz/models/quiz.dart';
import 'package:freequiz/quiz/quiz_helper.dart';

class ManageQuiz {
  static Future<Map> load(String uuid, bool preview) async {
    Map localQuiz = await QuizDatabase.loadQuiz(uuid);

    if (localQuiz.isEmpty) {
      final quiz = await APIQuizzes.getQuiz(uuid);
      if (quiz['success']) {
        QuizHelper.quiz = Quiz.fromJson(quiz['quiz_data']);
        QuizDatabase.insertQuiz(QuizHelper.quiz!);
      }
      return quiz;
    }

    var connectivityResult = await (Connectivity().checkConnectivity());
    if (!connectivityResult.contains(ConnectivityResult.none) && !preview) {
      final quiz = await APIQuizzes.getQuiz(uuid);
      if (quiz['success']) {
        QuizHelper.quiz = Quiz.fromJson(quiz['quiz_data']);
        QuizDatabase.insertQuiz(QuizHelper.quiz!);
      }
      return quiz;
    }

    if (!preview) {
      QuizHelper.quiz = Quiz.fromJson(localQuiz['quiz_data']);
    }

    return localQuiz;
  }

  static Future<Map> loadRecent() async {
    Map<String, List> recentQuizzes = {'data': []};

    List<Map> quizzes = await QuizDatabase.loadQuizzes();

    for (Map quiz in quizzes) {
      recentQuizzes['data']!.add(quiz);
    }

    return recentQuizzes;
  }
}
