import 'dart:math';
import 'package:freequiz/utilities/extensions/string_extensions.dart';
import 'package:freequiz/controllers/quiz/questionnaire.dart';
import 'package:freequiz/models/translation.dart';
import 'package:freequiz/controllers/quiz/quiz_helper.dart';

class Question {
  static List<String> choices = [];

  static randomChoices() {
    List<String> options = [];
    for (Translation translation in QuizHelper.quiz!.translations.translations) {
      options.add(translation.answer());
    }

    choices = [];
    options.remove(Questionnaire.answer()); //remove answer

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
    choices.insert(i, Questionnaire.answer());

    return choices;
  }

  static bool correct(String input) {
    String answer = Questionnaire.answer();
    return input.format() == answer.format();
  }
}