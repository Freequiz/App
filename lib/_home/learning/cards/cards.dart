import 'package:flutter/material.dart';
import 'package:freequiz/_home/learning/cards/cards_body.dart';
import 'package:freequiz/local_storage/quizzes.dart';
import 'package:freequiz/quiz/learning.dart';
import 'package:freequiz/quiz.dart';
import 'package:freequiz/others/initial_loading.dart';
import 'package:freequiz/others/style.dart';
import 'package:freequiz/quiz/questionnaire.dart';

class Cards extends StatefulWidget {
  final Function refresh;
  final String uuid;
  const Cards({super.key, required this.refresh, required this.uuid});

  @override
  State<Cards> createState() => _CardsState();
}

class _CardsState extends State<Cards> {
  bool answeredWrong = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(language["Cards"]),
        leading: TextButton(
          onPressed: () {
            close();
          },
          child: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
        ),
        backgroundColor: blueFreequiz,
      ),
      body: CardsBody(
        key: const Key('Back'),
        wrong: wrong,
        right: right,
        color: blueFreequiz,
      ),
    );
  }

  wrong() {
    answeredWrong = true;
    Questionnaire.answeredWrong();
    if (Questionnaire.questions.length > 1) {
      setState(() {
        Questionnaire.questions.removeAt(0);
        Learning.showAnswer = false;
      });
    } else {
      widget.refresh();
      LocalStorage.saveQuiz(widget.uuid, QuizHelper.quiz!.toMap());
      Navigator.of(context).pop();
    }
  }

  right() {
    if (!answeredWrong) {
      Questionnaire.answeredRight();
    }
    if (Questionnaire.questions.length > 1) {
      setState(() {
        answeredWrong = false;
        Questionnaire.questions.removeAt(0);
        Learning.showAnswer = false;
      });
    } else {
      widget.refresh();
      LocalStorage.saveQuiz(widget.uuid, QuizHelper.quiz!.toMap());
      Navigator.of(context).pop();
    }
  }

  close() {
    LocalStorage.saveQuiz(widget.uuid, QuizHelper.quiz!.toMap());
    widget.refresh();
    Navigator.of(context).pop();
  }
}
