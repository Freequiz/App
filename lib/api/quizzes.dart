import 'api.dart';

class APIQuizzes {
  static Future<Map> createQuiz(Map map) async {
    final response = await Api.httpPut(
      path: 'quiz/create',
      body: {"quiz": map},
    );

    return Api.decodeResponse(response);
  }

  static Future<Map> getDeleteToken(String id) async {
    final response = await Api.httpGet(path: 'quiz/$id/delete_token');

    return Api.decodeResponse(response);
  }

  static Future<Map> deleteQuiz(String deleteToken, String id) async {
    final response = await Api.httpDelete(path: 'quiz/$id/delete/$deleteToken');

    return Api.decodeResponse(response);
  }

  static Future<Map> getQuiz(String id) async {
    final response = await Api.httpGet(path: 'quiz/$id/data');

    return Api.decodeResponse(response);
  }

  static Future<Map> search(String searchTerm, int page) async {
    final response = await Api.httpGet(path: 'quiz/search/$page?query=$searchTerm');

    return Api.decodeResponse(response);
  }

  static Future<Map> updateQuiz(Map map, String id) async {
    final response = await Api.httpPatch(
      path: 'quiz/$id/update',
      body: {"quiz": map},
    );

    return Api.decodeResponse(response);
  }

  static Future<Map> setFavorite(String id, int scoreID, bool favorite) async {
    final response = await Api.httpPatch(path: 'quiz/$id/score/$scoreID/favorite', body: {"favorite": favorite});
    return Api.decodeResponse(response);
  }

  static Future<Map> setQuizFavorite(String id, bool favorite) async {
    final response = await Api.httpPatch(path: 'quiz/$id/favorite', body: {"favorite": favorite});
    return Api.decodeResponse(response);
  }

  static Future<Map> setScore(String id, int scoreID, String mode, int score) async {
    final response = await Api.httpPatch(
      path: 'quiz/$id/score/$scoreID/$mode',
      body: {"score": score},
    );

    return Api.decodeResponse(response);
  }

  static Future<Map> syncScore(String id, Map quizData) async {
    final response = await Api.httpPatch(
      path: 'quiz/$id/score/sync',
      body: {"quiz": quizData},
    );

    return Api.decodeResponse(response);
  }

  static Future<Map> resetScore(String id, String mode) async {
    final response = await Api.httpPatch(path: 'quiz/$id/score/reset/$mode', body: "");

    return Api.decodeResponse(response);
  }

  static Future<Map> report(String id, String type) async {
    Object body = {
      "quiz_report": {
        "sexual": "sexual" == type,
        "violence": "violence" == type,
        "hate": "hate" == type,
        "spam": "spam" == type,
        "child_abuse": "child_abuse" == type,
        "mobbing": "mobbing" == type,
      }
    };
    final response = await Api.httpPost(path: 'quiz/$id/report', body: body);

    return Api.decodeResponse(response);
  }
}
