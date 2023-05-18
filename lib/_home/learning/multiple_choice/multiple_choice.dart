import 'package:flutter/material.dart';
import 'package:freequiz/_home/learning/learning.dart';
import 'package:freequiz/_home/learning/multiple_choice/multiple_choice_body.dart';
import 'package:freequiz/quiz.dart';
import 'package:freequiz/others/initial_loading.dart';
import 'package:freequiz/others/style.dart';

class MultipleChoice extends StatefulWidget {
  final Function refresh;
  final String uuid;
  const MultipleChoice({super.key, required this.refresh, required this.uuid});

  @override
  State<MultipleChoice> createState() => _MultipleChoiceState();
}

class _MultipleChoiceState extends State<MultipleChoice> {
  List answerRight = List.filled(4, false);

  @override
  void initState() {
    Learning().randomChoices();
    super.initState();
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
        choices: Learning.choices,
        wrongAnswer: wrongAnswer,
        rightAnswer: rightAnswer,
        answerRight: answerRight,
        background: color3,
        color: backgroundGray,
      ),
    );
  }

  rightAnswer(i) {
    if (!Learning.answeredWrong) {
      Quiz().answeredRight("Multiple Choice");
    }
    setState(() {
      answerRight[i] = true;
    });
    Future.delayed(const Duration(milliseconds: 300), () {
      if (Quiz.indexArray.length > 1) {
        Learning.answeredWrong = false;
        Quiz.indexArray.removeAt(0);
        setState(() {
          Learning().newChoices();
        });
      } else {
        close();
      }
      answerRight = List.filled(4, false);
    });
  }

  wrongAnswer(String choice, int i) {
    Learning().wrongAnswerMultipleChoice(context, choice, rightAnswer, i);
  }

  close() {
    Learning().close(context, widget.refresh, widget.uuid, "MultipleChoice");
  }
}
