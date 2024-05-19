import 'package:freequiz/models/quiz.dart';
import 'package:freequiz/models/translation.dart';

class QuizHelper {
  static Quiz? quiz;

  static bool marked = false;
  static Map draft = {};

  final List<String> modes = [
    "Smart",
    "Writing",
    "MultipleChoice",
    "Cards",
  ];

  final modesAPI = ["smart", "write", "multi", "cards"];

  checkedIfMarkedWords() {
    QuizHelper.marked = false;
    for (Translation translation in quiz!.translations.translations) {
      if (!translation.favorite) continue;

      QuizHelper.marked = true;
      return;
    }
  }
}
