import 'package:flutter/material.dart';
import 'package:freequiz/_home/learning/learning.dart';
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
  List answerRightMC = List.filled(4, false);
  bool answerRightW = false;
  final _textController = TextEditingController();

  @override
  void initState() {
    Learning().randomChoices();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final modes = [
      MultipleChoiceBody(
        choices: Learning.choices,
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
            onPressed: () =>
                Learning().close(context, widget.refresh, widget.uuid, "Smart"),
            child: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
            ),
          ),
        ),
        body: modes[Learning().indexMode()]);
  }

  onPressed() {
    if (Learning().correct(_textController.text)) {
      rightAnswerW();
    } else {
      wrongAnswerW();
    }
  }

  wrongAnswerW() {
    setState(() {
      Learning().wrongAnswerWriting(_textController, context, rightAnswerW);
    });
  }

  rightAnswerW() {
    setState(() {
      answerRightW = true;
    });
    Future.delayed(const Duration(milliseconds: 200), () {
      if (!Learning.answeredWrong) {
        Quiz().answeredRight("Smart");
      }
      if (Quiz.indexArray.length > 1) {
        setState(() {
          Learning.answeredWrong = false;
          Quiz.indexArray.removeAt(0);
          _textController.clear();
          Learning().newChoices();
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
      if (!Learning.answeredWrong) {
        Quiz().answeredRight("Smart");
      }
      if (Quiz.indexArray.length > 1) {
        Learning.answeredWrong = false;
        Quiz.indexArray.removeAt(0);
        setState(() {
          Learning().newChoices();
        });
      } else {
        Learning().close(context, widget.refresh, widget.uuid, "Smart");
      }
      answerRightMC = List.filled(4, false);
    });
  }

  wrongAnswerMC(String choice, int i) {
    Learning().wrongAnswerMultipleChoice(context, choice, rightAnswerMC, i);
  }
}
