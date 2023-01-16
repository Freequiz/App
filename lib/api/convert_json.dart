import 'package:flutter/material.dart';
import 'package:freequiz/others/textfield_data.dart';

definitionArray(quiz) {
  List<String> definition = [];
  final List list = quiz['quiz_data']['data'];
  for (var i = 0; i < list.length; i++) {
    definition.add(list[i]['w']);
  }
  return definition;
}

answerArray(quiz) {
  List<String> answer = [];
  final List list = quiz['quiz_data']['data'];
  for (var i = 0; i < list.length; i++) {
    answer.add(list[i]['t']);
  }
  return answer;
}

map(String title, String description, String visibility, String from, String to,
    List<TextFieldData> definition, List<TextFieldData> answer) {
  List translations = [];
  for (var i = 0; i < definition.length; i++) {
    if (definition[i].input.text != "") {
      translations
          .add({'w': definition[i].input.text, 't': answer[i].input.text});
    } 
  }
  Map map = {
    'title': title,
    'description': description,
    'visibility': visibility,
    'from': from,
    'to': to,
    'data': translations
  };
  debugPrint(map.toString());
  return map;
}
