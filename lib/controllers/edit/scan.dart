import 'package:freequiz/controllers/edit/quiz_form.dart';
import 'package:freequiz/services/scan/scan.dart';

class Scan {
  static QuizForm quiz = QuizForm();

  static Future<void> main() async {
    final wordPairs = await scan();

    for (var i = 0; i < wordPairs.length; i++) {
      if (i >= quiz.wordPairs.length) {
        quiz.addWordPair();
      }

      quiz.wordPairs[i].definition.input.text = wordPairs[i]["definition"];
      quiz.wordPairs[i].answer.input.text = wordPairs[i]["answer"];
    }
  }
}