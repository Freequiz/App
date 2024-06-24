import 'package:easy_localization/easy_localization.dart';
import 'package:freequiz/others/utilities.dart';
import 'package:freequiz/quiz/learning.dart';
import 'package:freequiz/_home/learning/multiple_choice/multiple_choice_body.dart';
import 'package:freequiz/_home/learning/writing/writing_body.dart';
import 'package:freequiz/quiz/question.dart';
import 'package:freequiz/quiz/questionnaire.dart';
import 'package:freequiz/utilities/imports/base.dart';

class Smart extends StatefulWidget {
  const Smart({super.key});

  @override
  State<Smart> createState() => _SmartState();
}

class _SmartState extends State<Smart> {
  List answerRightMC = List.filled(4, false);
  bool answerRightW = false;
  final _textController = TextEditingController();

  @override
  void initState() {
    Question.randomChoices();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final modes = [
      MultipleChoiceBody(
        choices: Question.choices,
        wrongAnswer: wrongAnswerMC,
        rightAnswer: rightAnswerMC,
        answerRight: answerRightMC,
        color: purple,
      ),
      WritingBody(
        onPressed: onPressed,
        answerRight: answerRightW,
        textController: _textController,
        color: purple,
      )
    ];
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.darkMode ? purpleDark : purpleLight,
        title: Text(
          "Smart",
          style: textColor(Colors.white),
        ).tr(),
      ),
      body: modes[Questionnaire.questions[0].score['smart'] > 0 ? 1 : 0],
    );
  }

  onPressed() {
    if (Question.correct(_textController.text)) {
      rightAnswerW();
    } else {
      wrongAnswerW();
    }
  }

  wrongAnswerW() {
    setState(() {
      Learning().wrongAnswerWriting(_textController, context, rightAnswerW);
    });
  }

  rightAnswerW() {
    setState(() {
      answerRightW = true;
    });
    Future.delayed(const Duration(milliseconds: 200), () {
      if (!Learning.answeredWrong) {
        Questionnaire.answeredRight();
      }
      if (Questionnaire.questions.length > 1) {
        setState(() {
          Learning.answeredWrong = false;
          Questionnaire.questions.removeAt(0);
          _textController.clear();
          Question.randomChoices();
        });
      } else {
        if (mounted) {
          Navigator.of(context).pop();
        }
      }
      answerRightW = false;
    });
  }

  rightAnswerMC(i) {
    setState(() {
      answerRightMC[i] = true;
    });
    Future.delayed(const Duration(milliseconds: 200), () {
      if (!Learning.answeredWrong) {
        Questionnaire.answeredRight();
      }
      if (Questionnaire.questions.length > 1) {
        Learning.answeredWrong = false;
        Questionnaire.questions.removeAt(0);
        setState(() {
          Question.randomChoices();
        });
      } else {
        if (mounted) {
          Navigator.of(context).pop();
        }
      }
      answerRightMC = List.filled(4, false);
    });
  }

  wrongAnswerMC(String choice, int i) {
    Learning().wrongAnswerMultipleChoice(context, choice, rightAnswerMC, i);
  }
}
