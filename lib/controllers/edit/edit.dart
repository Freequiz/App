import 'package:freequiz/controllers/edit/quiz_form.dart';
import 'package:freequiz/services/scan/scan.dart' as services;

class EditController {
  static QuizForm quiz = QuizForm();

  static Future<void> scan() async {
    final wordPairs = await services.scan();

    int offset = 0;
    while (quiz.wordPairs[offset].definition.input.text.isNotEmpty || quiz.wordPairs[offset].answer.input.text.isNotEmpty) {
      offset += 1;
      if (offset >= quiz.wordPairs.length) break;
    }

    for (var i = 0; i < wordPairs.length; i++) {
      if (i+offset >= quiz.wordPairs.length) {
        quiz.addWordPair();
      }

      quiz.wordPairs[i+offset].definition.input.text = wordPairs[i]["definition"];
      quiz.wordPairs[i+offset].answer.input.text = wordPairs[i]["answer"];
    }
  }

  static void import(String string) {
    List<String> wordPairs = string.split('\n');
    for (var i = 0; i < wordPairs.length; i++) {
      if (i >= quiz.wordPairs.length) {
        quiz.addWordPair();
      }

      List<String> words = wordPairs[i].split('\t');
      quiz.wordPairs[i].definition.input.text = words[0];
      quiz.wordPairs[i].answer.input.text = words[1];
    }
  }
}