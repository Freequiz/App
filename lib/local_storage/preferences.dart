import 'package:shared_preferences/shared_preferences.dart';

class Preferences {

  static int answerLanguage = 1;

  static saveAnswerLanguage(int value) async {
    answerLanguage = value;
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('answer_language', value);
  }

  static loadAnswerLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    answerLanguage = prefs.getInt('answer language') ?? 1;
  }
}