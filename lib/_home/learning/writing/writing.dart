import 'package:flutter/material.dart';
import 'package:freequiz/_home/subviews/correction.dart';
import 'package:freequiz/_home/learning/writing/writing_body.dart';
import 'package:freequiz/_home/quiz.dart';
import 'package:freequiz/others/initial_loading.dart';
import 'package:freequiz/others/style.dart';

class Writing extends StatefulWidget {
  final Function refresh;
  const Writing({super.key, required this.refresh});

  @override
  State<Writing> createState() => _WritingState();
}

class _WritingState extends State<Writing> {
  final _textController = TextEditingController();
  bool answeredWrong = false;
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
          backgroundColor: color2,
        ),
        body: WritingBody(
          onPressed: onPressed,
          answerRight: answerRight,
          textController: _textController,
          color: color2,
        ));
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
      rightAnswer();
    } else {
      wrongAnswer();
    }
  }

  wrongAnswer() {
    final givenAnswer = _textController.text;
    showDialog(
      context: context,
      builder: (BuildContext context) => Correction(
        givenAnswer: givenAnswer,
        rightAnswer: Quiz.answer[Quiz.indexArray[0]],
      ),
    ).then((answerRight) {
      if (answerRight == null || !answerRight) {
        answeredWrong = true;
        if (Quiz.learnedDefinitions.contains(Quiz.indexArray[0])) {
          Quiz.learnedDefinitions.remove(Quiz.indexArray[0]);
          Quiz.newDefinitions.add(Quiz.indexArray[0]);
        } else if (Quiz.masteredDefinitions.contains(Quiz.indexArray[0])) {
          Quiz.masteredDefinitions.remove(Quiz.indexArray[0]);
          Quiz.newDefinitions.add(Quiz.indexArray[0]);
        }
      } else {
        rightAnswer();
      }
    });
    setState(() {
      _textController.clear();
    });
  }

  rightAnswer() {
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
      answerRight = true;
    });
    Future.delayed(const Duration(milliseconds: 300), () {
      if (Quiz.indexArray.length > 1) {
        setState(() {
          answeredWrong = false;
          Quiz.indexArray.removeAt(0);
          _textController.clear();
        });
      } else {
        close();
      }
      answerRight = false;
    });
  }

  close() {
    setState(() {
      FocusScope.of(context).requestFocus(FocusNode());
      Quiz().saveData("Writing", "example");
      Future.delayed(const Duration(milliseconds: 500), () {
        widget.refresh();
        Navigator.of(context).pop();
      });
    });
  }
}
