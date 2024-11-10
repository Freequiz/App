import 'package:easy_localization/easy_localization.dart';
import 'package:freequiz/_views/subviews/switcher/switcher.dart';
import 'package:freequiz/services/local_storage/preferences.dart';
import 'package:freequiz/controllers/quiz/learning.dart';
import 'package:freequiz/controllers/quiz/questionnaire.dart';
import 'package:freequiz/utilities/imports/utilities.dart';

class LearningSettings extends StatefulWidget {
  final List<String> languages;
  final String mode;
  const LearningSettings({super.key, required this.languages, required this.mode});

  @override
  State<LearningSettings> createState() => _LearningSettingsState();
}

class _LearningSettingsState extends State<LearningSettings> {
  List<String> languages = [];
  String answerLanguage = "";
  String maxScore = "";
  String lengthQuestionnaire = "";

  @override
  void initState() {
    if (widget.languages[0] == widget.languages[1]) {
      languages = ["definition", "answer"];
    }
    else {
      languages = widget.languages;
    }

    answerLanguage = languages[Preferences.answerLanguage];
    maxScore = Questionnaire.maxScore(widget.mode).toString();
    lengthQuestionnaire = Questionnaire.desiredLength().toString();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        context.tr('settings'),
        style: TextStyle(color: context.darkMode ? Colors.white : Colors.black),
      ),
      insetPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
      contentPadding: const EdgeInsets.all(20.0),
      content: Column(
        children: [
          const SizedBox(height: 20),
          Text(
            context.tr('answer with'),
            style: titleStyle(),
          ),
          const SizedBox(height: 5),
          Switcher(
            onTap: changeAnswerLanguage,
            texts: languages,
            value: answerLanguage,
            width: context.screenWidth - 80,
          ),
          const SizedBox(height: 30),
          Visibility(
            visible: Learning.maxScoreOptions[widget.mode]!.isNotEmpty,
            child: Text(
              context.tr('amount repetition'),
              style: titleStyle(),
            ),
          ),
          Visibility(
            visible: Learning.maxScoreOptions[widget.mode]!.isNotEmpty,
            child: const SizedBox(height: 5),
          ),
          Visibility(
            visible: Learning.maxScoreOptions[widget.mode]!.isNotEmpty,
            child: Switcher(
              onTap: changeMaxScore,
              texts: Learning.maxScoreOptions[widget.mode]!,
              value: maxScore,
              width: context.screenWidth - 80,
            ),
          ),
          Visibility(
            visible: Learning.maxScoreOptions[widget.mode]!.isNotEmpty,
            child: const SizedBox(height: 30),
          ),
          Text(
            context.tr('length round'),
            style: titleStyle(),
          ),
          const SizedBox(height: 5),
          Switcher(
            onTap: changeLengthQuestionnaire,
            texts: const ["5", "10", "20", "30"],
            value: lengthQuestionnaire,
            width: context.screenWidth - 80,
          ),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('close').tr(),
              )
            ],
          ),
        ),
      ],
    );
  }

  changeAnswerLanguage(String text) {
    Preferences.saveAnswerLanguage(languages.indexOf(text));
    setState(() {
      answerLanguage = text;
    });
  }

  changeMaxScore(String n) {
    Preferences.saveMaxScore(widget.mode, int.parse(n));
    setState(() {
      maxScore = n;
    });
  }

  changeLengthQuestionnaire(String length) {
    Preferences.saveLengthQuestionnaire(int.parse(length));
    setState(() {
      lengthQuestionnaire = length;
    });
  }
}
