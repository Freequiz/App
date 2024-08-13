import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:freequiz/local_storage/draft_storage.dart';
import 'package:freequiz/quiz/quiz_helper.dart';
import 'package:http/http.dart' as http;
import 'package:freequiz/2_profile/profile.dart';

import 'api.dart';

class APIUsers {
  static bool newAccessToken = false;

  static Future<Map> createAccount(
      String username, String email, String password, String passwordConfirmation, bool agb) async {
    final response = await Api.requestHandler(
      request: () {
        return http
            .put(
              Api.uri('user/create'),
              headers: {HttpHeaders.contentTypeHeader: "application/json"},
              encoding: Encoding.getByName('utf-8'),
              body: jsonEncode(
                {
                  "user": {
                    "username": username,
                    "email": email,
                    "password": password,
                    "password_confirmation": passwordConfirmation,
                    "agb": agb
                  }
                },
              ),
            )
            .timeout(const Duration(seconds: 10));
      },
    );

    if (response.statusCode == 201) {
      newAccessToken = true;
      return jsonDecode(response.body);
    } else if (response.statusCode == 400) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 401) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 500) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 503) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error');
    }
  }

  static Future<Map> getDeleteToken() async {
    final response = await Api.httpGet(path: 'user/delete_token');

    return Api.decodeResponse(response);
  }

  static Future<Map> deleteAccount(deleteToken, destroyQuizzes) async {
    final response = await Api.httpDelete(path: 'user/delete/$deleteToken?destroy_quizzes=$destroyQuizzes');

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
    final response = await Api.requestHandler(
      request: () {
        return http
            .post(
              Api.uri('user/login'),
              headers: {},
              encoding: Encoding.getByName('utf-8'),
              body: {
                "username": username,
                "password": password,
              },
            )
            .timeout(const Duration(seconds: 10));
      },
    );

    if (response.statusCode == 200) {
      newAccessToken = true;
      return jsonDecode(response.body);
    } else if (response.statusCode == 404) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 401) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 500) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 503) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error');
    }
  }

  static refresh() async {
    if (!newAccessToken && Profile.accessToken != "") {
      final response = await Api.httpPost(path: 'user/refresh', body: '');

      if (response.statusCode == 200) {
        final decodedResponse = jsonDecode(response.body);
        Profile.accessToken = decodedResponse["access_token"];
        Profile.saveAccessToken();
        newAccessToken = true;
      } else {
        debugPrint("Couldn't refresh Access Token");
      }
    }
  }

  static Future<Map> getData() async {
    final response = await Api.httpGet(path: 'user/data');

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 401) {
      Profile.deleteData();
      return jsonDecode(response.body);
    } else {
      try {
        return jsonDecode(response.body);
      }
      catch (_) {
        debugPrint("JSON couldn't be decoded");
        return Api.responseDefault;
      }
    }
  }

  static Future<Map> getFavorites() async {
    final response = await Api.httpGet(path: 'user/favorites/1');

    return Api.decodeResponse(response);
  }

  static Future<Map> search(String searchTerm, int page) async {
    final response = await Api.httpGet(path: 'user/search/$page?query=$searchTerm');

    return Api.decodeResponse(response);
  }

  static Future<Map> getQuizzesAndDraft(int page) async {
    final map = getQuizzes(page);
    QuizHelper.draft = await DraftStorage.loadDraft();
    return map;
  }

  static Future<Map> getQuizzes(int page) async {
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
    final response = await Api.httpPatch(
      path: 'user/update',
      body: username != ""
          ? {
              "user": {"username": username}
            }
          : email != ""
              ? {
                  "user": {"email": email}
                }
              : {
                  "user": {
                    "password": password,
                    "password_confirmation": passwordConfirmation,
                    "password_challenge": oldPassword
                  }
                },
    );

    return Api.decodeResponse(response);
  }

  static Future<Map> updateSettings(Map body) async {
    final response = await Api.httpPatch(path: 'user/settings', body: {"setting": body});

    return Api.decodeResponse(response);
  }
}
