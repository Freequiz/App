import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:freequiz/_home/learning/cards/cards_body.dart';
import 'package:freequiz/local_storage/database.dart';
import 'package:freequiz/quiz/learning.dart';
import 'package:freequiz/quiz/quiz_helper.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('cards').tr(),
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
    Questionnaire.answeredWrong();
    if (Questionnaire.questions.length > 1) {
      setState(() {
        Questionnaire.questions.removeAt(0);
        Learning.showAnswer = false;
      });
    } else {
      widget.refresh();
      QuizDatabase.updateQuiz(QuizHelper.quiz!); //TODO: Change to Update
      Navigator.of(context).pop();
    }
  }

  right() {
    Questionnaire.answeredRight();
    if (Questionnaire.questions.length > 1) {
      setState(() {
        Questionnaire.questions.removeAt(0);
        Learning.showAnswer = false;
      });
    } else {
      widget.refresh();
      QuizDatabase.updateQuiz(QuizHelper.quiz!);
      Navigator.of(context).pop();
    }
  }

  close() {
    QuizDatabase.updateQuiz(QuizHelper.quiz!);
    widget.refresh();
    Navigator.of(context).pop();
  }
}
