import 'package:flutter/material.dart';
import 'package:freequiz/_home/learning/cards/cards_body.dart';
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
  bool showAnswer = false;
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
        backgroundColor: color4,
      ),
      body: CardsBody(
        wrong: wrong,
        right: right,
        changeShowAnswer: changeShowAnswer,
        showAnswer: showAnswer,
        color: color4,
      ),
    );
  }

  changeShowAnswer() {
    showAnswer = !showAnswer;
  }

  wrong() {
    answeredWrong = true;
    Quiz().answeredWrong();
    if (Quiz.indexArray.length > 1) {
      setState(() {
        Quiz.indexArray.removeAt(0);
        showAnswer = false;
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
        showAnswer = false;
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
