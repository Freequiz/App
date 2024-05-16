import 'dart:convert';
import 'dart:io';
import 'package:freequiz/2_profile/profile.dart';
import 'package:freequiz/secrets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'api.dart';

class APIQuizzes {
  static Future<Map> createQuiz(Map map) async {
    final response = await Api.httpPut(
      path: 'quiz/create',
      body: jsonEncode({"quiz": map}),
    );

    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    }
    throw Exception('Error');
  }

  static Future<Map> getDeleteToken(String uuid) async {
    final response = await Api.httpGet(path: 'quiz/$uuid/delete_token');

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 401) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error');
    }
  }

  static Future<Map> deleteQuiz(String deleteToken, String uuid) async {
    final response =
        await Api.httpDelete(path: 'quiz/$uuid/delete/$deleteToken');

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 401) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error');
    }
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

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    if (response.statusCode == 401) {
      return jsonDecode(response.body);
    }
    if (response.statusCode == 404) {
      return jsonDecode(response.body);
    }
    throw Exception('Error');
  }

  static Future<Map> updateQuiz(Map map, String uuid) async {
    final response = await Api.httpPatch(
      path: 'quiz/$uuid/update',
      body: jsonEncode(
        {"quiz": map},
      ),
    );

    if (response.statusCode == 202) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 400) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 401) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error');
    }
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
    if (response.statusCode == 202) {
      return jsonDecode(response.body);
    }
    if (response.statusCode == 400) {
      return jsonDecode(response.body);
    }
    if (response.statusCode == 401) {
      return jsonDecode(response.body);
    }
    if (response.statusCode == 404) {
      return jsonDecode(response.body);
    }
    throw Exception('Error');
  }

  static Future<Map> setScore(String uuid, Map score) async {
    final response = await Api.httpPatch(
      path: 'quiz/$uuid/score',
      body: jsonEncode({"score": score}),
    );

    if (response.statusCode == 202) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 400) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 401) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 404) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error');
    }
  }

  static Future<Map> resetScore(String uuid, String mode) async {
    final response = await Api.httpPatch(path: 'quiz/$uuid/score/reset/$mode', body: "");

    if (response.statusCode == 202) {
      return jsonDecode(response.body);
    }
    if (response.statusCode == 400) {
      return jsonDecode(response.body);
    }
    if (response.statusCode == 401) {
      return jsonDecode(response.body);
    }
    if (response.statusCode == 404) {
      return jsonDecode(response.body);
    }
    throw Exception('Error');
  }
}
