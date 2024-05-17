import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:freequiz/api/convert_json.dart';
import 'package:freequiz/api/quizzes.dart';
import 'package:freequiz/quiz.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static Future<Map> getQuiz(String uuid, bool preview) async {
    if (!preview) {
      Quiz().manageQuizzes(uuid);
    }
    final prefs = await SharedPreferences.getInstance();
    Map localMap = await json.decode(prefs.getString(uuid) ?? "{}");
    if (localMap.isNotEmpty) {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult != ConnectivityResult.none && !preview) {
        final map = await APIQuizzes.getQuiz(uuid);
        if (map['success']) {
          Quiz.mapQuiz = map;
          Quiz.definition = await definitionArray(map);
          Quiz.answer = await answerArray(map);
          Quiz().loadMarked(uuid);
        }
        return map;
      } else {
        if (!preview) {
          Quiz.mapQuiz = localMap;
          Quiz.definition = await definitionArray(localMap);
          Quiz.answer = await answerArray(localMap);
          Quiz().loadLocalMarked(uuid);
        }
        return localMap;
      }
    } else {
      final map = await APIQuizzes.getQuiz(uuid);
      if (map['success']) {
        Quiz.mapQuiz = map;
        Quiz.definition = await definitionArray(map);
        Quiz.answer = await answerArray(map);
        Quiz().loadMarked(uuid);
      }
      return map;
    }
  }
}
