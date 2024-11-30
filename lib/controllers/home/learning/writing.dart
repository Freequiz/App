import 'package:freequiz/controllers/quiz/learning.dart';
import 'package:freequiz/controllers/quiz/question.dart';
import 'package:freequiz/controllers/quiz/questionnaire.dart';
import 'package:freequiz/utilities/imports/themes.dart';

class WritingController extends ChangeNotifier {
  final textController = TextEditingController();
  bool answerRight = false;

  void onPressed(BuildContext context) {
    if (Question.correct(textController.text)) {
      rightAnswer(context);
    } else {
      wrongAnswer(context);
    }
  }

  void rightAnswer(BuildContext context) {
    answerRight = true;
    notifyListeners();

    Future.delayed(const Duration(milliseconds: 300), () {
      if (!Learning.answeredWrong) {
        Questionnaire.answeredRight();
      }
      if (Questionnaire.questions.length > 1) {
        Learning.answeredWrong = false;
        Questionnaire.next();
        textController.clear();
        Question.randomChoices();
        notifyListeners();
      } else {
        if (context.mounted) Navigator.of(context).pop();
      }
      answerRight = false;
    });
  }

  void wrongAnswer(BuildContext context) {
    Learning().wrongAnswerWriting(textController, context, rightAnswer);
    notifyListeners();
  }
}
