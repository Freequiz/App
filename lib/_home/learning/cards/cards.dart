import 'package:flutter/material.dart';
import 'package:freequiz/_home/learning/cards/cards_body.dart';
import 'package:freequiz/_home/quiz.dart';
import 'package:freequiz/others/language.dart';
import 'package:freequiz/others/style.dart';

class Cards extends StatefulWidget {
  final Function refresh;
  const Cards({super.key, required this.refresh});

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
    if (Quiz.learnedDefinitions.contains(Quiz.indexArray[0])) {
      Quiz.learnedDefinitions.remove(Quiz.indexArray[0]);
      Quiz.newDefinitions.add(Quiz.indexArray[0]);
    } else if (Quiz.masteredDefinitions.contains(Quiz.indexArray[0])) {
      Quiz.masteredDefinitions.remove(Quiz.indexArray[0]);
      Quiz.newDefinitions.add(Quiz.indexArray[0]);
    }
    if (Quiz.indexArray.length > 1) {
      setState(() {
        Quiz.indexArray.removeAt(0);
        showAnswer = false;
      });
    } else {
      widget.refresh();
      Quiz().saveData("Cards", "example");
      Navigator.of(context).pop();
    }
  }

  right() {
    if (!answeredWrong) {
      if (Quiz.newDefinitions.contains(Quiz.indexArray[0])) {
        Quiz.newDefinitions.remove(Quiz.indexArray[0]);
        Quiz.learnedDefinitions.add(Quiz.indexArray[0]);
      } else if (Quiz.learnedDefinitions.contains(Quiz.indexArray[0])) {
        Quiz.learnedDefinitions.remove(Quiz.indexArray[0]);
        Quiz.masteredDefinitions.add(Quiz.indexArray[0]);
      }
    }
    if (Quiz.indexArray.length > 1) {
      setState(() {
        answeredWrong = false;
        Quiz.indexArray.removeAt(0);
        showAnswer = false;
      });
    } else {
      widget.refresh();
      Quiz().saveData("Cards", "example");
      Navigator.of(context).pop();
    }
  }

  close() {
    Quiz().saveData("Writing", "example");
    widget.refresh();
    Navigator.of(context).pop();
  }
}
