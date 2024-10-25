import 'package:freequiz/controllers/home/learning/learning.dart';
import 'package:freequiz/controllers/quiz/learning.dart';
import 'package:freequiz/controllers/quiz/question.dart';
import 'package:freequiz/controllers/quiz/questionnaire.dart';
import 'package:freequiz/utilities/imports/themes.dart';

class MultipleChoiceController with ChangeNotifier implements BaseLearningController {
  @override
  List answerRightMC = List.filled(4, false);

  @override
  void rightAnswerMC(BuildContext context, int i) {
    if (!Learning.answeredWrong) {
      Questionnaire.answeredRight();
    }

    answerRightMC[i] = true;
    notifyListeners();

    Future.delayed(const Duration(milliseconds: 300), () {
      if (Questionnaire.questions.length > 1) {
        Learning.answeredWrong = false;
        Questionnaire.questions.removeAt(0);
        Question.randomChoices();
        notifyListeners();
      } else {
        if (context.mounted) Navigator.of(context).pop();
      }
      answerRightMC = List.filled(4, false);
    });
  }

  @override
  void wrongAnswerMC(BuildContext context, String choice, int i) {
    Learning().wrongAnswerMultipleChoice(context, choice, rightAnswerMC, i);
  }
}