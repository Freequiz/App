import 'package:flutter/material.dart';
import 'package:freequiz/quiz/learning.dart';
import 'package:freequiz/_home/learning/writing/writing_body.dart';
import 'package:freequiz/others/initial_loading.dart';
import 'package:freequiz/others/style.dart';
import 'package:freequiz/quiz/question.dart';
import 'package:freequiz/quiz/questionnaire.dart';

class Writing extends StatefulWidget {
  final Function refresh;
  final String uuid;
  const Writing({super.key, required this.refresh, required this.uuid});

  @override
  State<Writing> createState() => _WritingState();
}

class _WritingState extends State<Writing> {
  final _textController = TextEditingController();
  bool answerRight = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(language["Writing"]),
          leading: TextButton(
            onPressed: () {
              close();
            },
            child: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
            ),
          ),
          backgroundColor: roseFreequiz,
        ),
        body: WritingBody(
          onPressed: onPressed,
          answerRight: answerRight,
          textController: _textController,
          color: roseFreequiz,
        ));
  }

  onPressed() {
    if (Question.correct(_textController.text)) {
      rightAnswer();
    } else {
      wrongAnswer();
    }
  }

  wrongAnswer() {
    setState(() {
      Learning().wrongAnswerWriting(_textController, context, rightAnswer);
    });
  }

  rightAnswer() {
    if (!Learning.answeredWrong) {
      Questionnaire.answeredRight();
    }
    setState(() {
      answerRight = true;
    });
    Future.delayed(const Duration(milliseconds: 300), () {
      if (Questionnaire.questions.length > 1) {
        setState(() {
          Learning.answeredWrong = false;
          Questionnaire.questions.removeAt(0);
          _textController.clear();
        });
      } else {
        close();
      }
      answerRight = false;
    });
  }

  close() {
    Learning().stop(context, widget.refresh, widget.uuid, "Writing");
  }
}
