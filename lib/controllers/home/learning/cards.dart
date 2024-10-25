import 'package:freequiz/controllers/quiz/learning.dart';
import 'package:freequiz/controllers/quiz/questionnaire.dart';
import 'package:freequiz/utilities/imports/themes.dart';

class CardsController extends ChangeNotifier {
  Key key = const Key("Card_0");

  void wrong(BuildContext context) {
    Questionnaire.answeredWrong();
    if (Questionnaire.questions.length > 1) {
      key = Key("Card_${Questionnaire.questions.length}");
      Questionnaire.questions.removeAt(0);
      Learning.showAnswer = false;
      notifyListeners();
    } else {
      Navigator.of(context).pop();
    }
  }

  void right(BuildContext context) {
    Questionnaire.answeredRight();
    if (Questionnaire.questions.length > 1) {
      key = Key("Card_${Questionnaire.questions.length}");
      Questionnaire.questions.removeAt(0);
      Learning.showAnswer = false;
      notifyListeners();
    } else {
      Navigator.of(context).pop();
    }
  }

  void close(BuildContext context) {
    Navigator.of(context).pop();
  }

  Color onUpdate(DismissUpdateDetails details, bool darkMode) {
    int r = darkMode ? 255 : 40;
    int g = darkMode ? 255 : 40;
    int b = darkMode ? 255 : 40;

    if (darkMode) {
      if (details.direction == DismissDirection.startToEnd) {
        r -= (details.progress * 205).toInt();
      } else {
        b -= (details.progress * 205).toInt();
        g -= (details.progress * 205).toInt();
      }
    } else {
      if (details.direction == DismissDirection.startToEnd) {
        g += (details.progress * 205).toInt();
        b += (details.progress * 205).toInt();
      } else {
        r += (details.progress * 205).toInt();
      }
    }

    return Color.fromARGB(255, r, g, b);
  }
}