import 'package:easy_localization/easy_localization.dart';
import 'package:freequiz/_home/learning/cards/cards_body.dart';
import 'package:freequiz/local_storage/database.dart';
import 'package:freequiz/others/utilities.dart';
import 'package:freequiz/quiz/learning.dart';
import 'package:freequiz/quiz/quiz_helper.dart';
import 'package:freequiz/quiz/questionnaire.dart';
import 'package:freequiz/utilities/imports/base.dart';

class Cards extends StatefulWidget {
  final Function refresh;
  final String uuid;
  const Cards({super.key, required this.refresh, required this.uuid});

  @override
  State<Cards> createState() => _CardsState();
}

class _CardsState extends State<Cards> {
  Key key = const Key("Card_0");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'cards',
          style: textColor(Colors.white),
        ).tr(),
        leading: TextButton(
          onPressed: () {
            close();
          },
          child: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
        ),
        backgroundColor: context.darkMode ? blueDark : blueLight,
      ),
      body: CardsBody(
        key: key,
        wrong: wrong,
        right: right,
        color: blue,
      ),
    );
  }

  wrong() {
    Questionnaire.answeredWrong();
    if (Questionnaire.questions.length > 1) {
      key = Key("Card_${Questionnaire.questions.length}");
      setState(() {
        Questionnaire.questions.removeAt(0);
        Learning.showAnswer = false;
      });
    } else {
      widget.refresh();
      QuizDatabase.updateQuiz(QuizHelper.quiz!);
      Navigator.of(context).pop();
    }
  }

  right() {
    Questionnaire.answeredRight();
    if (Questionnaire.questions.length > 1) {
      key = Key("Card_${Questionnaire.questions.length}");
      setState(() {
        Questionnaire.questions.removeAt(0);
        Learning.showAnswer = false;
      });
    } else {
      widget.refresh();
      QuizDatabase.updateQuiz(QuizHelper.quiz!);
      Navigator.of(context).pop();
    }
  }

  close() {
    QuizDatabase.updateQuiz(QuizHelper.quiz!);
    Learning.showAnswer = false;
    widget.refresh();
    Navigator.of(context).pop();
  }
}
