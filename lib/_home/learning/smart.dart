import 'package:flutter/material.dart';
import 'package:freequiz/_home/subviews/correction.dart';
import 'package:freequiz/_home/learning/multiple_choice/multiple_choice.dart';
import 'package:freequiz/_home/learning/multiple_choice/multiple_choice_body.dart';
import 'package:freequiz/_home/learning/writing/writing_body.dart';
import 'package:freequiz/_home/quiz.dart';
import 'package:freequiz/others/initial_loading.dart';
import 'package:freequiz/others/style.dart';

class Smart extends StatefulWidget {
  final Function refresh;
  const Smart({super.key, required this.refresh});

  @override
  State<Smart> createState() => _SmartState();
}

class _SmartState extends State<Smart> {
  bool answeredWrong = false;
  List answerRightMC = List.filled(4, false);
  bool answerRightW = false;
  final _textController = TextEditingController();
  List<String> choices = randomChoices(Quiz.answer, Quiz.indexArray[0]);

  @override
  Widget build(BuildContext context) {
    final modes = [
      MultipleChoiceBody(
        choices: choices,
        wrongAnswer: wrongAnswerMC,
        rightAnswer: rightAnswerMC,
        answerRight: answerRightMC,
        background: color5,
        color: Colors.white,
      ),
      WritingBody(
        onPressed: onPressed,
        answerRight: answerRightW,
        textController: _textController,
        color: color5,
      )
    ];
    return Scaffold(
        appBar: AppBar(
          backgroundColor: color5,
          title: Text(language["Smart"]),
          leading: TextButton(
            onPressed: () {
              close();
            },
            child: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
            ),
          ),
        ),
        body: modes[indexMode()]);
  }

  newChoices() {
    setState(() {
      choices = randomChoices(Quiz.answer, Quiz.indexArray[0]);
    });
  }

  onPressed() {
    if (_textController.text
            .trim()
            .replaceAll(',', ' ')
            .replaceAll('/', ' ')
            .replaceAll('.', ' ')
            .replaceAll(';', ' ')
            .replaceAll('(', ' ')
            .replaceAll(')', ' ')
            .replaceAll('   ', '')
            .replaceAll('  ', '') ==
        Quiz.answer[Quiz.indexArray[0]]
            .replaceAll(',', ' ')
            .replaceAll('/', ' ')
            .replaceAll('.', ' ')
            .replaceAll(';', ' ')
            .replaceAll('(', ' ')
            .replaceAll(')', ' ')
            .replaceAll('   ', '')
            .replaceAll('  ', '')) {
      rightAnswerW();
    } else {
      wrongAnswerW();
    }
  }

  wrongAnswerW() {
    answeredWrong = true;
    if (Quiz.learnedDefinitions.contains(Quiz.indexArray[0])) {
      Quiz.learnedDefinitions.remove(Quiz.indexArray[0]);
      Quiz.newDefinitions.add(Quiz.indexArray[0]);
    } else if (Quiz.masteredDefinitions.contains(Quiz.indexArray[0])) {
      Quiz.masteredDefinitions.remove(Quiz.indexArray[0]);
      Quiz.newDefinitions.add(Quiz.indexArray[0]);
    }
    final givenAnswer = _textController.text;
    showDialog(
      context: context,
      builder: (BuildContext context) => Correction(
        givenAnswer: givenAnswer,
        rightAnswer: Quiz.answer[Quiz.indexArray[0]],
      ),
    );
    setState(() {
      _textController.clear();
    });
  }

  rightAnswerW() {
    setState(() {
      answerRightW = true;
    });
    Future.delayed(const Duration(milliseconds: 200), () {
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
          _textController.clear();
        });
      } else {
        widget.refresh();
        Navigator.of(context).pop();
        Quiz().saveData("Smart", "example");
      }
      answerRightW = false;
    });
  }

  rightAnswerMC(i) {
    setState(() {
      answerRightMC[i] = true;
    });
    Future.delayed(const Duration(milliseconds: 200), () {
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
        answeredWrong = false;
        Quiz.indexArray.removeAt(0);
        newChoices();
      } else {
        close();
      }
      answerRightMC = List.filled(4, false);
    });
  }

  wrongAnswerMC(String choice) {
    answeredWrong = true;
    if (Quiz.learnedDefinitions.contains(Quiz.indexArray[0])) {
      Quiz.learnedDefinitions.remove(Quiz.indexArray[0]);
      Quiz.newDefinitions.add(Quiz.indexArray[0]);
    } else if (Quiz.masteredDefinitions.contains(Quiz.indexArray[0])) {
      Quiz.masteredDefinitions.remove(Quiz.indexArray[0]);
      Quiz.newDefinitions.add(Quiz.indexArray[0]);
    }
    showDialog(
      context: context,
      builder: (BuildContext context) => Correction(
        givenAnswer: choice,
        rightAnswer: Quiz.answer[Quiz.indexArray[0]],
      ),
    );
  }

  int indexMode() {
    if (Quiz.newDefinitions.contains(Quiz.indexArray[0])) {
      return 0;
    }
    return 1;
  }

  close() {
    FocusScope.of(context).requestFocus(FocusNode());
    Quiz().saveData("Writing", "example");
    Future.delayed(const Duration(milliseconds: 500), () {
      widget.refresh();
      Navigator.of(context).pop();
    });
  }
}
