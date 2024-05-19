import 'package:flutter/material.dart';
import 'package:freequiz/local_storage/quizzes.dart';
import 'package:freequiz/quiz/learning.dart';
import 'package:freequiz/_home/learning/multiple_choice/multiple_choice_body.dart';
import 'package:freequiz/_home/learning/writing/writing_body.dart';
import 'package:freequiz/quiz.dart';
import 'package:freequiz/others/initial_loading.dart';
import 'package:freequiz/others/style.dart';
import 'package:freequiz/quiz/question.dart';
import 'package:freequiz/quiz/questionnaire.dart';

class Smart extends StatefulWidget {
  final Function refresh;
  final String uuid;
  const Smart({super.key, required this.refresh, required this.uuid});

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
        background: purpleFreequiz,
        color: Colors.white,
      ),
      WritingBody(
        onPressed: onPressed,
        answerRight: answerRightW,
        textController: _textController,
        color: purpleFreequiz,
      )
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: purpleFreequiz,
        title: Text(language["Smart"]),
        leading: TextButton(
          onPressed: () =>
              Learning().stop(context, widget.refresh, widget.uuid, "Smart"),
          child: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
        ),
      ),
      body: modes[0],
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
        widget.refresh();
        Navigator.of(context).pop();
        LocalStorage.saveQuiz(widget.uuid, QuizHelper.quiz!.toMap());
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
        Learning().stop(context, widget.refresh, widget.uuid, "Smart");
      }
      answerRightMC = List.filled(4, false);
    });
  }

  wrongAnswerMC(String choice, int i) {
    Learning().wrongAnswerMultipleChoice(context, choice, rightAnswerMC, i);
  }
}
