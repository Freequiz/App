import 'dart:convert';
import 'dart:math';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:freequiz/api/quizzes.dart';
import 'package:freequiz/api/convert_json.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Quiz {
  static Map mapQuiz = {};
  static List<String> answer = [];
  static List<String> definition = [];
  static String title = "";
  static List<List<int>> progressArray = [[]];
  static List<int> indexArray = [];
  static List<bool> markedWords = [];
  static bool marked = false;
  static int amountDefinitions = 0;
  static int amountProgress = 0;
  static List<String> uuids = [];
  static Map draft = {};
  final List<String> modes = [
    "Smart",
    "Writing",
    "MultipleChoice",
    "Cards",
  ];
  final modesAPI = ["smart", "write", "multi", "cards"];

  Future<void> loadData(int mode, String uuid) async {
    progressArray = [[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[]];
    var connectivityResult = await (Connectivity().checkConnectivity());
    final prefs = await SharedPreferences.getInstance();
    final List<String> progress =
        prefs.getStringList("progress$mode$uuid") ?? [];
    if (connectivityResult != ConnectivityResult.none || progress.isEmpty) {
      final List list = mapQuiz['quiz_data']['data'];
      for (var i = 0; i < list.length; i++) {
        progressArray[list[i]['score'][modesAPI[mode]]].add(i);
      }
    } else {
      debugPrint(progress.toString());
      for (var i = 0; i < progress.length; i++) {
        progressArray[int.parse(progress[i])].add(i);
      }
      for (var i = 0; i < definition.length; i++) {
        for (var n = 0; n < progressArray.length; n++) {
          if (!progressArray[n].contains(i)) {
            if (n == progressArray.length - 1) {
              progressArray[0].add(i);
            }
          } else {
            n = 6942069420;
          }
        }
      }
    }
    calculateProgress(modes[mode] == "Smart" ? 0 : 1);
    return;
  }

  List<int> getIndexArray(array) {
    final List<int> arrayIndex = [];
    for (var i = 0; i < array.length; i++) {
      arrayIndex.add(i);
    }
    return arrayIndex; 
  }

  Future<void> deleteData(String mode, String uuid) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove("progress$mode$uuid");
    APIQuizzes().httpPatchResetScore(uuid, modesAPI[modes.indexOf(mode)]);
  }

  Future<void> loadLocalMarked(String uuid) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> markedWordsString = prefs.getStringList("mW$uuid") ?? [];
    markedWords = markedWordsString.map((e) => e == 'true').toList();
    if (markedWords.isEmpty) {
      markedWords = List.filled(definition.length, false);
    }
    checkedIfMarkedWords();
  }

  Future<void> loadMarked(uuid) async {
    List list = mapQuiz['quiz_data']['data'];
    markedWords.clear();
    for (var i = 0; i < list.length; i++) {
      markedWords.add(list[i]['favorite']);
    }
    saveMarked(uuid, "", "");
    checkedIfMarkedWords();
  }

  Future<void> saveMarked(String uuid, String add, String remove) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
        "mW$uuid", markedWords.map((e) => e.toString()).toList());
    if (add != "" || remove != "") {
      APIQuizzes().httpPatchFavorites(uuid, add, remove);
    }
  }

  Future<void> saveData(String mode, String uuid) async {
    List<String> progress = [];
    debugPrint(progressArray.toString());
    for (var i = 0; i < answer.length; i++) {
      for (var n = 0; n < progressArray.length; n++) {
        if (progressArray[n].contains(i)) {
          progress.add(n.toString());
        }
      }
    }
    debugPrint(progress.toString());
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList("progress$mode$uuid", progress);
    final score = mapScore(progress, modesAPI[modes.indexOf(mode)]);
    await APIQuizzes().httpPatchScore(uuid, score);
  }

  formatArray(onlyMarked) {
    indexArray.clear();
    var array = [];
    var length = 0;
    for (var n = 0; n < progressArray.length - 1; n++) {
      length += progressArray[n].length;
    }
    if (length > 0) {
      for (var n = 0; n < progressArray.length - 1; n++) {
        for (var i = 0; i < progressArray[n].length; i++) {
          if (onlyMarked) {
            if (markedWords[progressArray[n][i]]) {
              array.add(progressArray[n][i]);
            }
          } else {
            array.add(progressArray[n][i]);
          }
        }
      }
      randomiseArray(array);
    } else {
      var masteredDefinitions =
          List.from(progressArray[progressArray.length - 1]);
      if (onlyMarked) {
        for (var i = 0; i < masteredDefinitions.length; i++) {
          if (markedWords[masteredDefinitions[i]]) {
            array.add(masteredDefinitions[i]);
          }
        }
      } else {
        array = List.from(masteredDefinitions);
      }
      randomiseArray(array);
    }
  }

  randomiseArray(array) {
    if (array.length < 20) {
      amountDefinitions = array.length;
      for (var n = 0; n < array.length; n) {
        final i = Random().nextInt(array.length);
        indexArray.add(array[i]);
        array.removeAt(i);
      }
    } else {
      amountDefinitions = 20;
      for (var n = 0; n < 20; n++) {
        final i = Random().nextInt(array.length);
        indexArray.add(array[i]);
        array.removeAt(i);
      }
    }
  }

  List<String> definitionArray(indexArray) {
    List<String> definitions = [];
    for (var i = 0; i < indexArray.length; i++) {
      definitions.add(definition[indexArray[i]]);
    }
    return definitions;
  }

  List<String> answerArray(indexArray) {
    List<String> answers = [];
    for (var i = 0; i < indexArray.length; i++) {
      answers.add(answer[indexArray[i]]);
    }
    return answers;
  }

  manageQuizzes(uuid) async {
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
      for (var mode in modes) {
        prefs.remove("progress$mode$deleteUuid");
      }
      uuids.removeLast();
      uuids.insert(0, uuid);
      prefs.setStringList("uuids", uuids);
    }
  }

  saveUuids() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('uuids', uuids);
  }

  deleteQuiz(int i) {
    uuids.removeAt(i);
    uuids.add('');
    saveUuids();
  }

  calculateProgress(int mode) {
    amountProgress = 0;
    for (var n = 0; n < progressArray.length; n++) {
      amountProgress += progressArray[n].length * n;
    }
    amountProgress / (mode == 0 ? 4 : 2) * 2;
  }

  checkedIfMarkedWords() {
    Quiz.marked = false;
    for (var i = 0; i < Quiz.markedWords.length; i++) {
      if (Quiz.markedWords[i]) {
        Quiz.marked = true;
        return;
      }
    }
  }

  int amountUuids() {
    int amountUuids = 0;
    for (var i = 0; i < uuids.length; i++) {
      if (uuids[i] != "") {
        amountUuids += 1;
      }
    }
    return amountUuids;
  }

  answeredWrong() {
    for (var i = 0; i < progressArray.length; i++) {
      if (progressArray[i].contains(indexArray[0])) {
        debugPrint(i.toString());
        if (i > 0) {
          progressArray[i].remove(indexArray[0]);
          progressArray[i - 1].add(indexArray[0]);
        }
      }
    }
  }

  answeredRight(String mode) {
    if (mode == "Smart") {
      for (var i = progressArray.length - 1; i >= 0; i--) {
        if (progressArray[i].contains(indexArray[0])) {
          if (i < 15) {
            progressArray[i].remove(indexArray[0]);
            progressArray[i + 1].add(indexArray[0]);
          }
        }
      }
    } else {
      for (var i = progressArray.length - 1; i >= 0; i--) {
        if (progressArray[i].contains(indexArray[0])) {
          if (i < 2) {
            progressArray[i].remove(indexArray[0]);
            progressArray[i + 1].add(indexArray[0]);
          }
        }
      }
    }
  }

  saveDraft(Map map) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('draft', jsonEncode(map));
  }

  loadDraft() async {
    final prefs = await SharedPreferences.getInstance();
    draft = jsonDecode(prefs.getString('draft') ?? "{}");
  }

  deleteDraft() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('draft');
  }
}
