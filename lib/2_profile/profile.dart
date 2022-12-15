import 'package:shared_preferences/shared_preferences.dart';

class Profile {
  static String accessToken = "";
  static bool loaded = false;

  Future<void> saveData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("accessToken", accessToken);
  }

  Future<void> loadData() async {
    final prefs = await SharedPreferences.getInstance();
    accessToken = prefs.getString("accessToken") ?? "";
    loaded = true;
  }

  Future<void> deleteData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove("accessToken");
  }
}