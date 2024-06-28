import 'package:easy_localization/easy_localization.dart';
import 'package:freequiz/quiz/learning.dart';
import 'package:freequiz/_home/learning/multiple_choice/multiple_choice_body.dart';
import 'package:freequiz/quiz/question.dart';
import 'package:freequiz/quiz/questionnaire.dart';
import 'package:freequiz/utilities/imports/base.dart';

class MultipleChoice extends StatefulWidget {
  const MultipleChoice({super.key});

  @override
  State<MultipleChoice> createState() => _MultipleChoiceState();
}

class _MultipleChoiceState extends State<MultipleChoice> {
  List answerRight = List.filled(4, false);

  @override
  void initState() {
    Question.randomChoices();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'multiple choice',
          style: TextStyle(color: Colors.white),
        ).tr(),
        backgroundColor: context.darkMode ? beigeDark : beigeLight,
      ),
      body: MultipleChoiceBody(
        choices: Question.choices,
        wrongAnswer: wrongAnswer,
        rightAnswer: rightAnswer,
        answerRight: answerRight,
        color: beige,
      ),
    );
  }

  rightAnswer(i) {
    if (!Learning.answeredWrong) {
      Questionnaire.answeredRight();
    }
    setState(() {
      answerRight[i] = true;
    });
    Future.delayed(const Duration(milliseconds: 300), () {
      if (Questionnaire.questions.length > 1) {
        Learning.answeredWrong = false;
        Questionnaire.questions.removeAt(0);
        setState(() {
          Question.randomChoices();
        });
      } else {
        if (mounted) Navigator.of(context).pop();
      }
      answerRight = List.filled(4, false);
    });
  }

  wrongAnswer(String choice, int i) {
    Learning().wrongAnswerMultipleChoice(context, choice, rightAnswer, i);
  }
}
