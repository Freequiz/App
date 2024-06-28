import 'package:easy_localization/easy_localization.dart';
import 'package:freequiz/_home/learning/cards/cards_body.dart';
import 'package:freequiz/quiz/learning.dart';
import 'package:freequiz/quiz/questionnaire.dart';
import 'package:freequiz/utilities/imports/utilities.dart';

class Cards extends StatefulWidget {
  const Cards({super.key});

  @override
  State<Cards> createState() => _CardsState();
}

class _CardsState extends State<Cards> {
  Key key = const Key("Card_0");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'cards',
          style: TextStyle(color: Colors.white),
        ).tr(),
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
      Navigator.of(context).pop();
    }
  }

  close() {
    Navigator.of(context).pop();
  }
}
