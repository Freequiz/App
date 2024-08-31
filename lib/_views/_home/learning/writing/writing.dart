import 'package:easy_localization/easy_localization.dart';
import 'package:freequiz/controllers/quiz/learning.dart';
import 'package:freequiz/_views/_home/learning/writing/writing_body.dart';
import 'package:freequiz/controllers/quiz/question.dart';
import 'package:freequiz/controllers/quiz/questionnaire.dart';
import 'package:freequiz/utilities/imports/base.dart';

class Writing extends StatefulWidget {
  const Writing({super.key});

  @override
  State<Writing> createState() => _WritingState();
}

class _WritingState extends State<Writing> {
  final _textController = TextEditingController();
  bool answerRight = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'writing',
          style: TextStyle(color: Colors.white),
        ).tr(),
        foregroundColor: Colors.white,
        backgroundColor: context.darkMode ? roseDark : roseLight,
      ),
      body: WritingBody(
        onPressed: onPressed,
        answerRight: answerRight,
        textController: _textController,
        color: rose,
      ),
    );
  }

  onPressed() {
    if (Question.correct(_textController.text)) {
      rightAnswer();
    } else {
      wrongAnswer();
    }
  }

  wrongAnswer() {
    setState(() {
      Learning().wrongAnswerWriting(_textController, context, rightAnswer);
    });
  }

  rightAnswer() {
    if (!Learning.answeredWrong) {
      Questionnaire.answeredRight();
    }
    setState(() {
      answerRight = true;
    });
    Future.delayed(const Duration(milliseconds: 300), () {
      if (Questionnaire.questions.length > 1) {
        setState(() {
          Learning.answeredWrong = false;
          Questionnaire.questions.removeAt(0);
          _textController.clear();
        });
      } else {
        if (mounted) Navigator.of(context).pop();
      }
      answerRight = false;
    });
  }
}
