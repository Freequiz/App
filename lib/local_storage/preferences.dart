import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static int answerLanguage = 1;
  static Map<String, dynamic> maxScores = {};

  static saveAnswerLanguage(int value) async {
    answerLanguage = value;
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('answer_language', value);
  }

  static loadAnswerLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    answerLanguage = prefs.getInt('answer_language') ?? 1;
  }

  static saveMaxScore(String mode, int n) async {
    maxScores[mode] = n;
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('max_scores', jsonEncode(maxScores));
  }

  static loadMaxScores() async {
    final prefs = await SharedPreferences.getInstance();
    maxScores = jsonDecode(
      prefs.getString('max_scores') ?? "{\"smart\":3,\"write\":2,\"multi\":2,\"cards\":2}",
    );
  }
}
