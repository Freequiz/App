import 'package:freequiz/api/api.dart';
import 'package:freequiz/api/quizzes.dart';
import 'package:freequiz/local_storage/database.dart';
import 'package:freequiz/models/quiz.dart';
import 'package:freequiz/quiz/quiz_helper.dart';

class ManageQuiz {
  static Future<Map> load(String uuid, bool preview) async {
    Map localQuiz = await QuizDatabase.loadQuiz(uuid);
    final quiz = await APIQuizzes.getQuiz(uuid);

    if (quiz['success']) {
      QuizHelper.quiz = Quiz.fromJson(quiz['quiz_data']);
      QuizDatabase.insertQuiz(QuizHelper.quiz!);
      return quiz;
    }

    if (localQuiz.isEmpty) {
      return quiz;
    }

    if (quiz.containsKey('message')) {
      if (quiz['message'] == Api.noConnection || quiz['message'] == Api.timeout) {
        if (!preview) {
          QuizHelper.quiz = Quiz.fromJson(localQuiz);
        }

        quiz['quiz_data'] = localQuiz;
        quiz['offline_data'] = true;
        return quiz;
      }
    }

    return quiz;
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
