import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'api.dart';

class APIQuizzes {
  static Future<Map> createQuiz(Map map) async {
    final response = await Api.httpPut(
      path: 'quiz/create',
      body: jsonEncode({"quiz": map}),
    );

    return Api.decodeResponse(response);
  }

  static Future<Map> getDeleteToken(String uuid) async {
    final response = await Api.httpGet(path: 'quiz/$uuid/delete_token');

    return Api.decodeResponse(response);
  }

  static Future<Map> deleteQuiz(String deleteToken, String uuid) async {
    final response =
        await Api.httpDelete(path: 'quiz/$uuid/delete/$deleteToken');

    return Api.decodeResponse(response);
  }

  static Future<Map> getQuiz(String uuid) async {
    final response = await Api.httpGet(path: 'quiz/$uuid/data');

    if (response.statusCode == 200) {
      final map = jsonDecode(response.body);
      final prefs = await SharedPreferences.getInstance();
      prefs.setString(uuid, json.encode(map));
      return map;
    }
    if (response.statusCode == 404) {
      final map = jsonDecode(response.body);
      return map;
    }
    throw Exception('Error');
  }

  static Future<Map> search(String searchTerm, int page) async {
    final response =
        await Api.httpGet(path: 'quiz/search/$page?query=$searchTerm');

    return Api.decodeResponse(response);
  }

  static Future<Map> updateQuiz(Map map, String uuid) async {
    final response = await Api.httpPatch(
      path: 'quiz/$uuid/update',
      body: jsonEncode(
        {"quiz": map},
      ),
    );

    return Api.decodeResponse(response);
  }

  static Future<Map> setFavorites(
      String uuid, String add, String remove) async {
    final response = await Api.httpPatch(
      path: 'quiz/$uuid/favorites',
      body: add != ""
          ? jsonEncode({
              "favorites": {
                "add": [add]
              }
            })
          : jsonEncode(
              {
                "favorites": {
                  "remove": [remove]
                }
              },
            ),
    );
    return Api.decodeResponse(response);
  }

  static Future<Map> setScore(String uuid, Map score) async {
    final response = await Api.httpPatch(
      path: 'quiz/$uuid/score',
      body: jsonEncode({"score": score}),
    );

    return Api.decodeResponse(response);
  }

  static Future<Map> resetScore(String uuid, String mode) async {
    final response = await Api.httpPatch(path: 'quiz/$uuid/score/reset/$mode', body: "");

    return Api.decodeResponse(response);
  }
}
