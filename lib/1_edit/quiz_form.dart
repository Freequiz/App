import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:freequiz/others/textfield_data.dart';

class QuizForm {
  final title = TextFieldData(hint: 'title'.tr());
  final description = TextFieldData(hint: 'description'.tr());

  String visibility = "public";

  List<WordPair> wordPairs = [
    WordPair(key: "1"),
    WordPair(key: "2"),
    WordPair(key: "3")
  ];

  List<WordPair> destroyed = [];

  int counter = 0;
  bool error = false;

  int definitionLanguage = 1;
  int answerLanguage = 3;

  Map createMap() {
    Map<String, Map> translations = {};

    for (WordPair wordPair in wordPairs) {
      Map<String, Map> map = wordPair.toMap();
      if (wordPair.definition.input.text == "") {
        map[wordPair.key]!["_destroy"] = "1";
      }
      translations.addAll(map);
    }

    for (WordPair wordPair in destroyed) {
      Map<String, Map> map = wordPair.toMap();
      map[wordPair.key]!["_destroy"] = "1";
      translations.addAll(map);
    }

    Map map = {
      'title': title.input.value.text,
      'description': description.input.value.text,
      'visibility': visibility,
      'from': definitionLanguage.toString(),
      'to': answerLanguage.toString(),
      'translations_attributes': translations
    };

    debugPrint(map.toString());
    return map;
  }

  bool emptyDefinition(i) {
    if (wordPairs[i].definition.input.text.replaceAll(' ', '') != "") return false;
    if (wordPairs[i].answer.input.text.replaceAll(' ', '') == "") return false;
    return true;
  }

  bool emptyAnswer(i) {
    if (wordPairs[i].answer.input.text.replaceAll(' ', '') != "") return false;
    if (wordPairs[i].definition.input.text.replaceAll(' ', '') == "") return false;
    return true;
  }

  bool empty(i) {
    if (wordPairs[i].answer.input.text.replaceAll(' ', '') != "") return false;
    if (wordPairs[i].definition.input.text.replaceAll(' ', '') != "") return false;
    return true;
  }

  checkForErrors() {
    error = false;
    counter = 0;

    for (var i = 0; i < wordPairs.length; i++) {
      if (emptyDefinition(i)) {
        wordPairs[i].definition.error = true;
        wordPairs[i].definition.input.clear();
        error = true;
      } else if (emptyAnswer(i)) {
        wordPairs[i].answer.error = true;
        wordPairs[i].answer.input.clear();
        error = true;
      } else if (empty(i)) {
      } else {
        counter++;
      }
    }

    if (counter < 3) {
      error = true;
    }

    if (title.input.text.replaceAll(' ', '').length < 3) {
      title.error = true;
      title.input.clear();
      error = true;
    }

    if (description.input.text.replaceAll(' ', '').length < 5) {
      description.error = true;
      description.input.clear();
      error = true;
    }
  }

  addWordPair() {
    wordPairs
        .add(WordPair(key: DateTime.now().microsecondsSinceEpoch.toString()));
  }
}

class WordPair {
  String key;
  int? id;

  final definition = TextFieldData(hint: 'definition'.tr());

  final answer = TextFieldData(hint: 'answer'.tr());

  WordPair({required this.key});

  toMap() {
    Map<String, Map> map = {
      key: {
        "word": definition.input.text,
        "translation": answer.input.text,
      }
    };

    if (id != null) {
      map[key]!['id'] = id!.toString();
    }

    return map;
  }
}
