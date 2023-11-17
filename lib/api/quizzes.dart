import 'dart:convert';
import 'dart:io';
import 'package:freequiz/2_profile/profile.dart';
import 'package:freequiz/quiz.dart';
import 'package:freequiz/api/convert_json.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'infos.dart';

class APIQuizzes {
  Future<Map> getQuiz(String uuid, bool preview) async {
    if (!preview) {
      Quiz().manageQuizzes(uuid);
    }
    final prefs = await SharedPreferences.getInstance();
    Map localMap = await json.decode(prefs.getString(uuid) ?? "{}");
    if (localMap.isNotEmpty) {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult != ConnectivityResult.none && !preview) {
        final map = await httpGetQuiz(uuid);
        if (map['success']) {
          Quiz.mapQuiz = map;
          Quiz.definition = await definitionArray(map);
          Quiz.answer = await answerArray(map);
          Quiz().loadMarked(uuid);
        }
        return map;
      } else {
        if (!preview) {
          Quiz.mapQuiz = localMap;
          Quiz.definition = await definitionArray(localMap);
          Quiz.answer = await answerArray(localMap);
          Quiz().loadLocalMarked(uuid);
        }
        return localMap;
      }
    } else {
      final map = await httpGetQuiz(uuid);
      if (map['success']) {
        Quiz.mapQuiz = map;
        Quiz.definition = await definitionArray(map);
        Quiz.answer = await answerArray(map);
        Quiz().loadMarked(uuid);
      }
      return map;
    }
  }

  Future<Map> httpGetQuiz(String uuid) async {
    final response = await http.get(
      Uri.parse('${ApiInfos.basePath}/quiz/$uuid/data'),
      headers: {
        "Authorization": ApiInfos.bearerToken,
        "Access-token": Profile.accessToken
      },
    );
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

  Future<Map> httpPatchFavorites(String uuid, String add, String remove) async {
    final response = await http.patch(
      Uri.parse('${ApiInfos.basePath}/quiz/$uuid/favorites'),
      headers: {
        "Authorization": ApiInfos.bearerToken,
        "Access-token": Profile.accessToken,
        HttpHeaders.contentTypeHeader: "application/json"
      },
      encoding: Encoding.getByName('utf-8'),
      body: add != ""
          ? jsonEncode({
              "favorites": {
                "add": [add]
              }
            })
          : jsonEncode({
              "favorites": {
                "remove": [remove]
              }
            }),
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

  Future<Map> httpPatchScore(String uuid, Map score) async {
    final response = await http.patch(
      Uri.parse('${ApiInfos.basePath}/quiz/$uuid/score'),
      headers: {
        "Authorization": ApiInfos.bearerToken,
        "Access-token": Profile.accessToken,
        HttpHeaders.contentTypeHeader: "application/json"
      },
      encoding: Encoding.getByName('utf-8'),
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

  Future<Map> httpPatchResetScore(String uuid, String mode) async {
    final response = await http.patch(
      Uri.parse(
          '${ApiInfos.basePath}/quiz/$uuid/score/reset/$mode'),
      headers: {
        "Authorization": ApiInfos.bearerToken,
        "Access-token": Profile.accessToken,
        HttpHeaders.contentTypeHeader: "application/json"
      },
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

  Future<Map> httpGetSearch(String searchTerm, int page) async {
    final response = await http.get(
      Uri.parse(
          '${ApiInfos.basePath}/quiz/search/$page?query=$searchTerm'),
      headers: {
        "Authorization": ApiInfos.bearerToken,
        "Access-token": Profile.accessToken
      },
    );

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

  Future<Map> httpPutQuiz(Map map) async {
    final response = await http.put(
      Uri.parse('${ApiInfos.basePath}/quiz/create'),
      headers: {
        "Authorization": ApiInfos.bearerToken,
        "Access-token": Profile.accessToken,
        HttpHeaders.contentTypeHeader: "application/json"
      },
      encoding: Encoding.getByName('utf-8'),
      body: jsonEncode({"quiz": map}),
    );
    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    }
    throw Exception('Error');
  }

  Future<Map> httpDeleteQuiz(String deleteToken, String uuid) async {
    final response = await http.delete(
      Uri.parse(
          '${ApiInfos.basePath}/quiz/$uuid/delete/$deleteToken'),
      headers: {
        "Authorization": ApiInfos.bearerToken,
        "Access-token": Profile.accessToken,
      },
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 401) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error');
    }
  }

  Future<Map> httpGetDeleteTokenQuiz(String uuid) async {
    final response = await http.get(
      Uri.parse('${ApiInfos.basePath}/quiz/$uuid/delete_token'),
      headers: {
        "Authorization": ApiInfos.bearerToken,
        "Access-token": Profile.accessToken
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 401) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error');
    }
  }

  Future<Map> httpPatchQuiz(Map map, String uuid) async {
    final response = await http.patch(
      Uri.parse('${ApiInfos.basePath}/quiz/$uuid/update'),
      headers: {
        "Authorization": ApiInfos.bearerToken,
        "Access-token": Profile.accessToken,
        HttpHeaders.contentTypeHeader: "application/json"
      },
      encoding: Encoding.getByName('utf-8'),
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
}
