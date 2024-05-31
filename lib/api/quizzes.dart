import 'api.dart';

class APIQuizzes {
  static Future<Map> createQuiz(Map map) async {
    final response = await Api.httpPut(
      path: 'quiz/create',
      body: {"quiz": map},
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

    return Api.decodeResponse(response);
  }

  static Future<Map> search(String searchTerm, int page) async {
    final response =
        await Api.httpGet(path: 'quiz/search/$page?query=$searchTerm');

    return Api.decodeResponse(response);
  }

  static Future<Map> updateQuiz(Map map, String uuid) async {
    final response = await Api.httpPatch(
      path: 'quiz/$uuid/update',
      body:
        {"quiz": map},
    );

    return Api.decodeResponse(response);
  }

  static Future<Map> setFavorite(String uuid, int scoreID, bool favorite) async {
    final response = await Api.httpPatch(
      path: 'quiz/$uuid/score/$scoreID/favorite',
      body: {"favorite": favorite}
    );
    return Api.decodeResponse(response);
  }

  static Future<Map> setQuizFavorite(String uuid, bool favorite) async {
    final response = await Api.httpPatch(
      path: 'quiz/$uuid/favorite',
      body: {"favorite": favorite}
    );
    return Api.decodeResponse(response);
  }

  static Future<Map> setScore(String uuid, int scoreID, String mode, int score) async {
    final response = await Api.httpPatch(
      path: 'quiz/$uuid/score/$scoreID/$mode',
      body: {"score": score},
    );

    return Api.decodeResponse(response);
  }

  static Future<Map> resetScore(String uuid, String mode) async {
    final response =
        await Api.httpPatch(path: 'quiz/$uuid/score/reset/$mode', body: "");

    return Api.decodeResponse(response);
  }
}
