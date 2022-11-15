import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';

class Quiz {
  static List<String> answer = [];
  static List<String> definition = [];
  static String title = "";
  static List<int> newDefinitions = [];
  static List<int> learnedDefinitions = [];
  static List<int> masteredDefinitions = [];
  static List<int> indexArray = [];
  static List<bool> markedWords = [];
  static bool marked = false;
  static int amountDefinitions = 0;
  static int amountProgress = 0;
  static List<String> uuids = [];
  final List<String> modes = [
    "Smart",
    "Writing",
    "MultipleChoice",
    "Cards",
  ];

  Future<void> loadData(String mode, String uuid) async {
    newDefinitions = [];
    learnedDefinitions = [];
    masteredDefinitions = [];
    final prefs = await SharedPreferences.getInstance();
    final List<String> progress =
        prefs.getStringList("progress$mode$uuid") ?? [];
    for (var i = 0; i < progress.length; i++) {
      if (progress[i] == "0") {
        newDefinitions.add(i);
      } else if (progress[i] == "1") {
        learnedDefinitions.add(i);
      } else {
        masteredDefinitions.add(i);
      }
    }
    for (var i = 0; i < definition.length; i++) {
      if (!newDefinitions.contains(i) &&
          !learnedDefinitions.contains(i) &&
          !masteredDefinitions.contains(i)) {
        newDefinitions.add(i);
      }
    }
    calculateProgress();
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
  }

  Future<void> loadMarked(String uuid) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> markedWordsString = prefs.getStringList("mW$uuid") ?? [];
    markedWords = markedWordsString.map((e) => e == 'true').toList();
    if (markedWords.isEmpty) {
      markedWords = List.filled(definition.length, false);
    }
    checkedIfMarkedWords();
  }

  Future<void> saveMarked(String uuid) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
        "mW$uuid", markedWords.map((e) => e.toString()).toList());
  }

  Future<void> saveData(String mode, String uuid) async {
    List<String> progress = [];
    for (var i = 0; i < answer.length; i++) {
      if (newDefinitions.contains(i)) {
        progress.add("0");
      } else if (learnedDefinitions.contains(i)) {
        progress.add("1");
      } else {
        progress.add("2");
      }
    }
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList("progress$mode$uuid", progress);
  }

  formatArray(onlyMarked) {
    indexArray.clear();
    var array = [];
    if (newDefinitions.length + learnedDefinitions.length > 0) {
      if (onlyMarked) {
        for (var i = 0; i < newDefinitions.length; i++) {
          if (markedWords[newDefinitions[i]]) {
            array.add(newDefinitions[i]);
          }
        }
      } else {
        array = List.from(newDefinitions);
      }
      for (var i = 0; i < learnedDefinitions.length; i++) {
        if (onlyMarked) {
          if (markedWords[learnedDefinitions[i]]) {
            array.add(learnedDefinitions[i]);
          }
        } else {
          array.add(learnedDefinitions[i]);
        }
      }
      randomiseArray(array);
    } else {
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

  calculateProgress() {
    amountProgress = 0;
    amountProgress += learnedDefinitions.length;
    amountProgress += masteredDefinitions.length * 2;
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
}
 