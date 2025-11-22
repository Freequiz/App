import 'package:freequiz/controllers/edit/quiz_form.dart';

class Import {
  static QuizForm quiz = QuizForm();
  
  static void main(String string) {
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
