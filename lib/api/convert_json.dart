import 'package:flutter/material.dart';
import 'package:freequiz/quiz.dart';
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

mapQuiz(
    {required String title,
    required String description,
    required String visibility,
    required String from,
    required String to,
    required List<TextFieldData> definitions,
    required List<TextFieldData> answers,
    bool noBlank = true}) {
  List translations = [];
  if (noBlank) {
    for (var i = 0; i < definitions.length; i++) {
      if (definitions[i].input.text != "") {
        translations
            .add({'w': definitions[i].input.text, 't': answers[i].input.text});
      }
    }
  } else {
    for (var i = 0; i < definitions.length; i++) {
      translations
          .add({'w': definitions[i].input.text, 't': answers[i].input.text});
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

mapScore(List score, String mode) {
  Map map = {};
  for (var i = 0; i < score.length; i++) {
    map.addAll({
      Quiz.mapQuiz['quiz_data']['data'][i]['hash']: {mode: int.parse(score[i])}
    });
  }
  return map;
}
