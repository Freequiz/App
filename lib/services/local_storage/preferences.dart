import 'dart:convert';
import 'package:freequiz/controllers/profile/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static int answerLanguage = 1;
  static String theme = "Automatic";

  static Future<void> saveAnswerLanguage(int value) async {
    answerLanguage = value;
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('answer_language', value);
  }

  static Future<void> loadAnswerLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    answerLanguage = prefs.getInt('answer_language') ?? 1;
  }

  static Future<void> saveMaxScore(String mode, int n) async {
    UserHelper.user!.settings.setScore(mode, n);
    saveUser();
  }

  static Future<void> saveLengthQuestionnaire(int length) async {
    UserHelper.user!.settings.setLengthQuestionnaire(length);
    saveUser();
  }

  static Future<void> saveUser() async {
    Map map = UserHelper.user!.toMap();
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('user', jsonEncode(map));
  }

  static Future<void> deleteUser() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('user');
  }

  static Future<Map> loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    return jsonDecode(
      prefs.getString('user') ?? "{\"username\": \"\", \"email\": \"\", \"settings\": {\"multi_amount\": 2, \"write_amount\": 2, \"cards_amount\": 2, \"round_amount\": 10}}",
    );
  }

  static Future<void> setTheme(String theme) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('theme', theme);
  }

  static Future<void> getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    theme = prefs.getString('theme') ?? "Automatic";
  }
}
