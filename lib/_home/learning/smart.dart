import 'package:flutter/material.dart';
import 'package:freequiz/_home/subviews/correction.dart';
import 'package:freequiz/_home/learning/multiple_choice/multiple_choice.dart';
import 'package:freequiz/_home/learning/multiple_choice/multiple_choice_body.dart';
import 'package:freequiz/_home/learning/writing/writing_body.dart';
import 'package:freequiz/quiz.dart';
import 'package:freequiz/others/initial_loading.dart';
import 'package:freequiz/others/style.dart';

class Smart extends StatefulWidget {
  final Function refresh;
  final String uuid;
  const Smart({super.key, required this.refresh, required this.uuid});

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
    final givenAnswer = _textController.text;
    showDialog(
      context: context,
      builder: (BuildContext context) => Correction(
        givenAnswer: givenAnswer,
        rightAnswer: Quiz.answer[Quiz.indexArray[0]],
      ),
    ).then((answerRight) {
      if (!answerRight) {
        answeredWrong = true;
        Quiz().answeredWrong();
      } else {
        rightAnswerW();
      }
    });
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
        Quiz().answeredRight("Smart");
      }
      if (Quiz.indexArray.length > 1) {
        setState(() {
          answeredWrong = false;
          Quiz.indexArray.removeAt(0);
          _textController.clear();
          newChoices();
        });
      } else {
        widget.refresh();
        Navigator.of(context).pop();
        Quiz().saveData("Smart", widget.uuid);
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
        Quiz().answeredRight("Smart");
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

  wrongAnswerMC(String choice, int i) {
    showDialog(
      context: context,
      builder: (BuildContext context) => Correction(
        givenAnswer: choice,
        rightAnswer: Quiz.answer[Quiz.indexArray[0]],
      ),
    ).then((answerRight) {
      if (answerRight == null || !answerRight) {
        answeredWrong = true;
        Quiz().answeredWrong();
      } else {
        rightAnswerMC(i);
      }
    });
  }

  int indexMode() {
    if (Quiz.progressArray[0].contains(Quiz.indexArray[0])) {
      return 0;
    }
    return 1;
  }

  close() {
    FocusScope.of(context).requestFocus(FocusNode());
    Quiz().saveData("Smart", widget.uuid);
    Future.delayed(const Duration(milliseconds: 500), () {
      widget.refresh();
      Navigator.of(context).pop();
    });
  }
}
