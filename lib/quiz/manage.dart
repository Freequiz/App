import 'package:flutter/material.dart';
import 'package:freequiz/api/api.dart';
import 'package:freequiz/api/quizzes.dart';
import 'package:freequiz/local_storage/database.dart';
import 'package:freequiz/models/quiz.dart';
import 'package:freequiz/quiz/quiz_helper.dart';

class ManageQuiz {
  static Future<Map> load(String uuid, bool sync) async {
    Map mapLocalQuiz = await QuizDatabase.loadQuiz(uuid);

    // If the quiz isn't stored locally, load it from the server and store it if request was successful
    if (mapLocalQuiz.isEmpty) {
      final quiz = await APIQuizzes.getQuiz(uuid);

      if (quiz['success']) {
        QuizHelper.quiz = Quiz.fromJson(quiz['quiz_data']);
        QuizDatabase.insertQuiz(QuizHelper.quiz!);
      }

      return quiz;
    }

    final localQuiz = Quiz.fromJson(mapLocalQuiz);

    // sync or get quiz from server
    Map? quiz;
    if (sync) {
      debugPrint(localQuiz.favorite.toString());
      debugPrint(localQuiz.toMapSync().toString());
      quiz = await APIQuizzes.syncScore(uuid, localQuiz.toMapSync());
      debugPrint(quiz['quiz_data']['favorite'].toString());
    }
    else {
      quiz = await APIQuizzes.getQuiz(uuid);
    }

    // return quiz if request is successful
    if (quiz['success']) {
      QuizHelper.quiz = Quiz.fromJson(quiz['quiz_data']);
      QuizDatabase.insertQuiz(QuizHelper.quiz!);
      return quiz;
    }

    // return localQuiz if request wasn't successful because of the internet connection
    if (quiz.containsKey('message')) {
      if (quiz['message'] == Api.noConnection || quiz['message'] == Api.timeout) {
        QuizHelper.quiz = localQuiz;

        quiz['quiz_data'] = localQuiz;
        quiz['offline_data'] = true;
        return quiz;
      }
    }

    return quiz;
  }

  static Future<Map> loadRecent() async {
    Map<String, dynamic> recentQuizzes = {'success': true,'data': []};

    List<Map> quizzes = await QuizDatabase.loadQuizzes();

    for (Map quiz in quizzes) {
      recentQuizzes['data']!.add(quiz);
    }

    return recentQuizzes;
  }
}
