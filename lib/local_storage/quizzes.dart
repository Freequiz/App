import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static List<String> uuids = [];

  static Future<Map> getQuiz(String uuid) async {
    final prefs = await SharedPreferences.getInstance();
    return await json.decode(prefs.getString(uuid) ?? "{}");
  }

  static Future<void> saveQuiz(String uuid, Map map) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(uuid, json.encode(map));
  }

  static Future<void> removeQuiz(String uuid) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(uuid);
  }

  static manageQuizzes(uuid) async {
    final prefs = await SharedPreferences.getInstance();
    uuids = prefs.getStringList("uuids") ?? ["", "", "", "", "", ""];
    if (uuids.contains(uuid)) {
      final i = uuids.indexOf(uuid);
      if (i != 0) {
        uuids.remove(uuid);
        uuids.insert(0, uuid);
        prefs.setStringList("uuids", uuids);
      }
    } else {
      final deleteUuid = uuids.last;
      prefs.remove(deleteUuid);
      uuids.removeLast();
      uuids.insert(0, uuid);
      prefs.setStringList("uuids", uuids);
    }
  }

  static saveUuids() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('uuids', uuids);
  }

  static deleteQuiz(int i) {
    uuids.removeAt(i);
    uuids.add('');
    saveUuids();
  }

  static saveDraft(Map map) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('draft', jsonEncode(map));
  }

  static Future<Map> loadDraft() async {
    final prefs = await SharedPreferences.getInstance();
    return jsonDecode(prefs.getString('draft') ?? "{}");
  }

  static deleteDraft() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('draft');
  }

  static int amountUuids() {
    int amountUuids = 0;
    for (var i = 0; i < uuids.length; i++) {
      if (uuids[i] != "") {
        amountUuids += 1;
      }
    }
    return amountUuids;
  }
}
