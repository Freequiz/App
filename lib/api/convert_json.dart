import 'package:freequiz/quiz.dart';

definitionArray(quiz) {
  List<String> definition = [];
  final List list = quiz['quiz_data']['data'];
  for (var i = 0; i < list.length; i++) {
    definition.add(list[i]['word']);
  }
  return definition;
}

answerArray(quiz) {
  List<String> answer = [];
  final List list = quiz['quiz_data']['data'];
  for (var i = 0; i < list.length; i++) {
    answer.add(list[i]['translation']);
  }
  return answer;
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
