import 'dart:convert';
import 'package:freequiz/_home/quiz.dart';
import 'package:freequiz/api/convert_json.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool newAccessToken = false;

Future<Map> getQuiz(String uuid, bool manageQuizzes) async {
  if (manageQuizzes) {
    Quiz().manageQuizzes(uuid);
  }
  final prefs = await SharedPreferences.getInstance();
  Map map = await json.decode(prefs.getString(uuid) ?? "{}");
  if (map.isNotEmpty) {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      httpGetQuiz(uuid);
      Quiz.definition = definitionArray(map);
      Quiz.answer = answerArray(map);
      Quiz().loadMarked("example");
      return map;
    } else {
      Quiz.definition = definitionArray(map);
      Quiz.answer = answerArray(map);
      Quiz().loadMarked("example");
      return map;
    }
  } else {
    return httpGetQuiz(uuid);
  }
}

Future<Map> httpGetQuiz(String uuid) async {
  await Future.delayed(const Duration(milliseconds: 1000), () {});
  final map = {
    "success": true,
    "data": {
      "title": "Hello",
      "description": "Just a simple test quiz!",
      "from": "English",
      "to": "German",
      "data": {
        "0": {"word": "A", "translation": "A"},
        "1": {"word": "B", "translation": "B"},
        "2": {"word": "C", "translation": "C"},
        "3": {"word": "D", "translation": "D"},
        "4": {"word": "E", "translation": "E"},
        "5": {"word": "F", "translation": "F"},
        "6": {"word": "G", "translation": "G"},
        "7": {"word": "H", "translation": "H"},
        "8": {"word": "I", "translation": "I"},
        "9": {"word": "J", "translation": "J"},
        "10": {"word": "K", "translation": "K"},
        "11": {"word": "L", "translation": "L"},
        "12": {"word": "M", "translation": "M"},
        "13": {"word": "N", "translation": "N"},
        "14": {"word": "O", "translation": "O"},
        "15": {"word": "P", "translation": "P"},
        "16": {"word": "Q", "translation": "Q"},
        "17": {"word": "R", "translation": "R"},
        "18": {"word": "S", "translation": "S"},
        "19": {"word": "T", "translation": "T"}
      }
    }
  };
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString(uuid, json.encode(map));
  Quiz.definition = definitionArray(map);
  Quiz.answer = answerArray(map);
  Quiz().loadMarked("example");
  return map;

  /*final response = await http.get(
    Uri.parse('https://shadowcrafter.org/api/quiz/example/data'),
    headers: {
      "Authorization":
          "Bearer 3b589393da6bc000705e75c9ae2fec24442fe09bad96b1f31645f9813abc1924",
      "Session-token": Profile.sessionToken
    },
  );
  if (response.statusCode == 200) {
    final map = jsonDecode(response.body);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        "example", json.encode(map));
    Quiz.definition = definitionArray(map);
    Quiz.answer = answerArray(map);
    Quiz().loadMarked("example");
    return map;
  } 
  else {
    throw Exception('Error');
  }*/
}

Future<Map> httpSearch(String searchTerm) async {
  await Future.delayed(const Duration(milliseconds: 1000));
  return {
    "success": true,
    "message": "Access token is invalid",
    "data": {
      "0": "example",
      "1": "example",
      "2": "example",
      "3": "example",
      "4": "example",
      "5": "example",
      "6": "example",
      "7": "example",
      "8": "example"
    }
  };
}
