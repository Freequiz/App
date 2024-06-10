import 'dart:convert';
import 'package:freequiz/user/helper.dart';
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
    answerLanguage = prefs.getInt('answer_language') ?? 1;
  }

  static saveMaxScore(String mode, int n) async {
    UserHelper.user!.settings.setScore(mode, n);
    saveUser();
  }

  static saveUser() async {
    Map map = UserHelper.user!.toMap();
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('user', jsonEncode(map));
  }

  static Future<Map> loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    return jsonDecode(
      prefs.getString('user') ?? "{\"username\": \"\", \"email\": \"\", \"settings\": {\"multi_amount\": 2, \"write_amount\": 2, \"cards_amount\": 2}}",
    );
  }
}
