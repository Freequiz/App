import 'package:shared_preferences/shared_preferences.dart';

class Profile {
  static String sessionToken = "";
  static int date = 0;
  static bool loaded = false;

  Future<void> saveData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("sessionToken", sessionToken);
    await prefs.setInt("date", date);
  }

  Future<void> loadData() async {
    final prefs = await SharedPreferences.getInstance();
    sessionToken = prefs.getString("sessionToken") ?? "";
    date = prefs.getInt("date") ?? 0;
    loaded = true;
  }

  Future<void> deleteData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove("sessionToken");
    prefs.remove("date");
  }
}