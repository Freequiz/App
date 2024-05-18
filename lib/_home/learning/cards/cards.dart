import 'package:flutter/material.dart';
import 'package:freequiz/_home/learning/cards/cards_body.dart';
import 'package:freequiz/_home/learning/learning.dart';
import 'package:freequiz/quiz.dart';
import 'package:freequiz/others/initial_loading.dart';
import 'package:freequiz/others/style.dart';

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
    Quiz().answeredWrong();
    if (Quiz.indexArray.length > 1) {
      setState(() {
        Quiz.indexArray.removeAt(0);
        Learning.showAnswer = false;
      });
    } else {
      widget.refresh();
      Quiz().saveData("Cards", widget.uuid);
      Navigator.of(context).pop();
    }
  }

  right() {
    if (!answeredWrong) {
      Quiz().answeredRight("Cards");
    }
    if (Quiz.indexArray.length > 1) {
      setState(() {
        answeredWrong = false;
        Quiz.indexArray.removeAt(0);
        Learning.showAnswer = false;
      });
    } else {
      widget.refresh();
      Quiz().saveData("Cards", widget.uuid);
      Navigator.of(context).pop();
    }
  }

  close() {
    Quiz().saveData("Writing", widget.uuid);
    widget.refresh();
    Navigator.of(context).pop();
  }
}
