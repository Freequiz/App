import 'package:flutter/material.dart';
import 'package:freequiz/others/initial_loading.dart';
import 'package:freequiz/others/textfield_data.dart';

class QuizForm {
  final title = TextFieldData(hint: language["Title"]);
  final description = TextFieldData(hint: language["Description"]);

  String visibility = "public";

  List<TextFieldData> definitions = [
    TextFieldData(hint: language["Definition"]),
    TextFieldData(hint: language["Definition"]),
    TextFieldData(hint: language["Definition"])
  ];

  List<TextFieldData> answers = [
    TextFieldData(hint: language["Answer"]),
    TextFieldData(hint: language["Answer"]),
    TextFieldData(hint: language["Answer"])
  ];

  int definitionLanguage = 1;
  int answerLanguage = 3;

  Map createMap() {
    Map<String, Map> translations = {};

    for (var i = 0; i < definitions.length; i++) {
      if (definitions[i].input.text != "") {
        translations["$i"] = {
          'word': definitions[i].input.text,
          'translation': answers[i].input.text
        };
      }
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
    if (definitions[i].input.text.replaceAll(' ', '') != "") return false;
    if (answers[i].input.text.replaceAll(' ', '') == "") return false;
    return true;
  }

  bool emptyAnswer(i) {
    if (answers[i].input.text.replaceAll(' ', '') != "") return false;
    if (definitions[i].input.text.replaceAll(' ', '') == "") return false;
    return true;
  }

  (int, bool, List<int>, List<int>) checkWordPairs() {
    int counter = 0;
    bool error = false;
    
    List<int> emptyDefinitions = [];
    List<int> emptyAnswers = [];

    for (var i = 0; i < definitions.length; i++) {
      if (emptyDefinition(i)) {
        emptyDefinitions.add(i);
        error = true;
      } else if (emptyAnswer(i)) {
        emptyAnswers.add(i);
        error = true;
      } else {
        counter++;
      }
    }

    return (counter, error, emptyDefinitions, emptyAnswers);
  }
}
