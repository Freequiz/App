import 'package:flutter/material.dart';
import 'package:freequiz/others/textfield_data.dart';

definitionArray(quiz) {
  List<String> definition = [];
  quiz['data']['data'].forEach((i, pair) {
    definition.add(pair['word']);
  });
  return definition;
}

answerArray(quiz) {
  List<String> answer = [];
  quiz['data']['data'].forEach((i, pair) {
    answer.add(pair['translation']);
  });
  return answer;
}

map(String title, String description, String from, String to, List<TextFieldData> definition, List<TextFieldData> answer) {
  Map translations = {};
  for (var i = 0; i < definition.length; i++) {
    if (definition[i].input.text != "") {
      translations.addAll({i.toString(): {'word': definition[i].input.text,'translation': answer[i].input.text}});
    }
    else {
      definition.removeAt(i);
      i--;
    }
  }
  Map map = {'title': title, 'description': description, 'from': from, 'to': to,'data': translations};
  debugPrint(map.toString());
  return map;
}
