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

  int counter = 0;
  bool error = false;

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

  bool empty(i) {
    if (answers[i].input.text.replaceAll(' ', '') != "") return false;
    if (definitions[i].input.text.replaceAll(' ', '') != "") return false;
    return true;
  }

  checkForErrors() {
    error = false;
    counter = 0;

    for (var i = 0; i < definitions.length; i++) {
      if (emptyDefinition(i)) {
        definitions[i].error = true;
        definitions[i].input.clear();
        error = true;
      } else if (emptyAnswer(i)) {
        answers[i].error = true;
        answers[i].input.clear();
        error = true;
      }
      else if (empty(i)) {} 
      else {
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
}
