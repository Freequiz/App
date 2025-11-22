import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class DraftStorage {
  static Future<void> saveDraft(Map map) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('draft', jsonEncode(map));
  }

  static Future<Map> loadDraft() async {
    final prefs = await SharedPreferences.getInstance();
    return jsonDecode(prefs.getString('draft') ?? "{}");
  }

  static Future<void> deleteDraft() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('draft');
  }
}
