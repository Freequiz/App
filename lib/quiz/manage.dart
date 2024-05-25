import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:freequiz/api/quizzes.dart';
import 'package:freequiz/local_storage/quizzes.dart';
import 'package:freequiz/models/quiz.dart';
import 'package:freequiz/quiz/quiz_helper.dart';

class ManageQuiz {
  static Future<Map> load(String uuid, bool preview) async {
    if (!preview) {
      LocalStorage.manageQuizzes(uuid);
    }

    Map localQuiz = await LocalStorage.getQuiz(uuid);

    if (localQuiz.isEmpty) {
      final quiz = await APIQuizzes.getQuiz(uuid);
      if (quiz['success']) {
        QuizHelper.quiz = Quiz.fromJson(quiz['quiz_data']);
        //QuizHelper().loadMarked(uuid);
      }
      return quiz;
    }

    var connectivityResult = await (Connectivity().checkConnectivity());
    if (!connectivityResult.contains(ConnectivityResult.none) && !preview) {
      final quiz = await APIQuizzes.getQuiz(uuid);
      if (quiz['success']) {
        QuizHelper.quiz = Quiz.fromJson(quiz['quiz_data']);
        //QuizHelper().loadMarked(uuid);
      }
      return quiz;
    }

    if (!preview) {
      QuizHelper.quiz = Quiz.fromJson(localQuiz['quiz_data']);
      //QuizHelper().loadLocalMarked(uuid);
    }

    return localQuiz;
  }

  static Future<Map> loadRecent() async {
    Map<String, List> recentQuizzes = {'data': []};
    for (String uuid in LocalStorage.uuids) {
      if (uuid == "") break;
      final quiz = await load(uuid, true);
      recentQuizzes['data']!.add(quiz['quiz_data']!);
    }

    return recentQuizzes;
  }
}
