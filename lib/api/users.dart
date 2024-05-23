import 'dart:convert';
import 'dart:io';
import 'package:freequiz/local_storage/quizzes.dart';
import 'package:freequiz/quiz/quiz_helper.dart';
import 'package:http/http.dart' as http;
import 'package:freequiz/2_profile/profile.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'api.dart';

class APIUsers {
  static bool newAccessToken = false;

  static Future<Map> createAccount(String username, String email, String password,
      String passwordConfirmation, bool agb) async {
    final response = await http.put(
      Api.uri('user/create'),
      headers: {
        HttpHeaders.contentTypeHeader: "application/json"
      },
      encoding: Encoding.getByName('utf-8'),
      body: jsonEncode({
        "user": {
          "username": username,
          "email": email,
          "password": password,
          "password_confirmation": passwordConfirmation,
          "agb": agb
        }
      }),
    );
    if (response.statusCode == 201) {
      newAccessToken = true;
      return jsonDecode(response.body);
    } else if (response.statusCode == 400) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 401) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error');
    }
  }

  static Future<Map> getDeleteToken() async {
    final response = await Api.httpGet(path: 'user/delete_token');

    return Api.decodeResponse(response);
  }

  static Future<Map> deleteAccount(deleteToken) async {
    final response = await Api.httpDelete(path: 'user/delete/$deleteToken');

    if (response.statusCode == 200) {
      Profile.accessToken = "";
      Profile.deleteData();
      return jsonDecode(response.body);
    } else if (response.statusCode == 401) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error');
    }
  }

  static Future<Map> login(String username, String password) async {
    final response = await http.post(
      Api.uri('user/login'),
      headers: {},
      encoding: Encoding.getByName('utf-8'),
      body: {
        "username": username,
        "password": password,
      },
    );

    if (response.statusCode == 200) {
      newAccessToken = true;
      return jsonDecode(response.body);
    } else if (response.statusCode == 404) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 401) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error');
    }
  }

  static refresh() async {
    if (!newAccessToken && Profile.accessToken != "") {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult.contains(ConnectivityResult.mobile) ||
          connectivityResult.contains(ConnectivityResult.wifi)) {
        final response = await Api.httpPost(path: 'user/refresh');

        if (response.statusCode == 200) {
          final decodedResponse = jsonDecode(response.body);
          Profile.accessToken = decodedResponse["access_token"];
          Profile.saveData();
          newAccessToken = true;
        } else if (response.statusCode == 401) {
          return jsonDecode(response.body);
        } else {
          throw Exception('Error');
        }
      }
    }
  }

  static Future<Map> getData() async {
    final response = await Api.httpGet(path: 'user/data');

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 401) {
      Profile.accessToken = "";
      Profile.deleteData();
      return jsonDecode(response.body);
    } else {
      throw Exception('Error');
    }
  }

  static Future<Map> getFavorites() async {
    final response = await Api.httpGet(path: 'user/favorites/1');

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 401) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error');
    }
  }

  static Future<Map> search(String searchTerm, int page) async {
    final response =
        await Api.httpGet(path: 'user/search/$page?query=$searchTerm');

    return Api.decodeResponse(response);
  }

  static Future<Map> getQuizzes(int page) async {
    final map = httpGetQuizzes(page);
    QuizHelper.draft = await LocalStorage.loadDraft();
    return map;
  }

  static Future<Map> httpGetQuizzes(int page) async {
    final response = await Api.httpGet(path: 'user/quizzes/$page');

    return Api.decodeResponse(response);
  }

  static Future<Map> getPublicQuizzes(int page, String username) async {
    final response = await Api.httpGet(path: 'user/$username/public/$page');

    return Api.decodeResponse(response);
  }

  static Future<Map> updateAccount(
      {String username = "",
      String email = "",
      String password = "",
      String passwordConfirmation = "",
      String oldPassword = ""}) async {
    final response = await Api.httpPut(
      path: 'user/update',
      body: username != ""
          ? jsonEncode({
              "user": {"username": username}
            })
          : email != ""
              ? jsonEncode({
                  "user": {"email": email}
                })
              : jsonEncode(
                  {
                    "user": {
                      "password": password,
                      "password_confirmation": passwordConfirmation,
                      "old_password": oldPassword
                    }
                  },
                ),
    );

    return Api.decodeResponse(response);
  }
}
