import 'package:freequiz/controllers/quiz/learning.dart';
import 'package:freequiz/controllers/quiz/question.dart';
import 'package:freequiz/controllers/quiz/questionnaire.dart';
import 'package:freequiz/utilities/imports/themes.dart';

class SmartController extends ChangeNotifier {
  bool answerRightW = false;
  List answerRightMC = List.filled(4, false);
  final textController = TextEditingController();

  onPressed(BuildContext context) {
    if (Question.correct(textController.text)) {
      rightAnswerW(context);
    } else {
      wrongAnswerW(context);
    }
  }

  rightAnswerW(BuildContext context) {
    answerRightW = true;
    notifyListeners();

    Future.delayed(const Duration(milliseconds: 200), () {
      if (!Learning.answeredWrong) {
        Questionnaire.answeredRight();
      }
      if (Questionnaire.questions.length > 1) {
        Learning.answeredWrong = false;
        Questionnaire.questions.removeAt(0);
        textController.clear();
        Question.randomChoices();
        notifyListeners();
      } else {
        if (context.mounted) {
          Navigator.of(context).pop();
        }
      }
      answerRightW = false;
    });
  }

  wrongAnswerW(context) {
    Learning().wrongAnswerWriting(textController, context, rightAnswerW);
    notifyListeners();
  }

  rightAnswerMC(BuildContext context, int i) {
    answerRightMC[i] = true;
    notifyListeners();

    Future.delayed(const Duration(milliseconds: 200), () {
      if (!Learning.answeredWrong) {
        Questionnaire.answeredRight();
      }
      if (Questionnaire.questions.length > 1) {
        Learning.answeredWrong = false;
        Questionnaire.questions.removeAt(0);
        Question.randomChoices();
        notifyListeners();
      } else {
        if (context.mounted) {
          Navigator.of(context).pop();
        }
      }
      answerRightMC = List.filled(4, false);
    });
  }

  wrongAnswerMC(BuildContext context, String choice, int i) {
    Learning().wrongAnswerMultipleChoice(context, choice, rightAnswerMC, i);
  }
}
