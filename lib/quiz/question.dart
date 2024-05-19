import 'dart:math';
import 'package:freequiz/others/string_extensions.dart';
import 'package:freequiz/quiz/questionnaire.dart';
import 'package:freequiz/models/translation.dart';
import 'package:freequiz/quiz/quiz_helper.dart';

class Question {
  static List<String> choices = [];

  static randomChoices() {
    List<String> options = [];
    for (Translation translation in QuizHelper.quiz!.translations.translations) {
      options.add(translation.translation);
    }

    choices = [];
    options.remove(Questionnaire.questions[0].translation); //remove answer

    for (var n = 0; n < 3; n++) {
      if (options.isNotEmpty) {
        int i = Random().nextInt(options.length);
        choices.add(options[i]);
        options.removeAt(i);
      } else {
        choices.add('');
      }
    }
    
    int i = Random().nextInt(4);
    choices.insert(i, Questionnaire.questions[0].translation);

    return choices;
  }

  static bool correct(String input) {
    return input.format() == Questionnaire.questions[0].translation.format();
  }
}