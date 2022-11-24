import 'package:flutter/material.dart';
import 'package:freequiz/_home/subviews/correction.dart';
import 'package:freequiz/_home/learning/multiple_choice/multiple_choice_body.dart';
import 'dart:math';
import 'package:freequiz/_home/quiz.dart';
import 'package:freequiz/others/initial_loading.dart';
import 'package:freequiz/others/style.dart';

class MultipleChoice extends StatefulWidget {
  final Function refresh;
  const MultipleChoice({super.key, required this.refresh});

  @override
  State<MultipleChoice> createState() => _MultipleChoiceState();
}

class _MultipleChoiceState extends State<MultipleChoice> {
  List<String> choices = randomChoices(Quiz.answer, Quiz.indexArray[0]);
  bool answeredWrong = false;
  List answerRight = List.filled(4, false);

  newChoices() {
    setState(() {
      choices = randomChoices(Quiz.answer, Quiz.indexArray[0]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(language["Multiple Choice"]),
          leading: TextButton(
            onPressed: () {
              close();
            },
            child: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
            ),
          ),
          backgroundColor: color3,
        ),
        body: MultipleChoiceBody(
          choices: choices,
          wrongAnswer: wrongAnswer,
          rightAnswer: rightAnswer,
          answerRight: answerRight,
          background: color3,
          color: backgroundGray,
        ));
  }

  rightAnswer(i) {
    if (!answeredWrong) {
      if (Quiz.newDefinitions.contains(Quiz.indexArray[0])) {
        Quiz.newDefinitions.remove(Quiz.indexArray[0]);
        Quiz.learnedDefinitions.add(Quiz.indexArray[0]);
      } else if (Quiz.learnedDefinitions.contains(Quiz.indexArray[0])) {
        Quiz.learnedDefinitions.remove(Quiz.indexArray[0]);
        Quiz.masteredDefinitions.add(Quiz.indexArray[0]);
      }
    }
    setState(() {
      answerRight[i] = true;
    });
    Future.delayed(const Duration(milliseconds: 300), () {
      if (Quiz.indexArray.length > 1) {
        answeredWrong = false;
        Quiz.indexArray.removeAt(0);
        newChoices();
      } else {
        widget.refresh();
        Navigator.of(context).pop();
        Quiz().saveData("MultipleChoice", "example");
      }
      answerRight = List.filled(4, false);
    });
  }

  wrongAnswer(String choice, int i) {
    showDialog(
      context: context,
      builder: (BuildContext context) => Correction(
        givenAnswer: choice,
        rightAnswer: Quiz.answer[Quiz.indexArray[0]],
      ),
    ).then((answerRight) {
      if (!answerRight) {
        answeredWrong = true;
        if (Quiz.learnedDefinitions.contains(Quiz.indexArray[0])) {
          Quiz.learnedDefinitions.remove(Quiz.indexArray[0]);
          Quiz.newDefinitions.add(Quiz.indexArray[0]);
        } else if (Quiz.masteredDefinitions.contains(Quiz.indexArray[0])) {
          Quiz.masteredDefinitions.remove(Quiz.indexArray[0]);
          Quiz.newDefinitions.add(Quiz.indexArray[0]);
        }
      } else {
        rightAnswer(i);
      }
    });
  }

  close() {
    Quiz().saveData("Writing", "example");
    widget.refresh();
    Navigator.of(context).pop();
  }
}

randomChoices(array, iAnswer) {
  List<String> copyArray = array.toList();
  List<String> choices = [];
  copyArray.removeAt(iAnswer);
  for (var n = 0; n < 3; n++) {
    int i = Random().nextInt(copyArray.length);
    choices.add(copyArray[i]);
    copyArray.removeAt(i);
  }
  int i = Random().nextInt(4);
  choices.insert(i, array[iAnswer]);
  return choices;
}
