import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:freequiz/_views/switcher/switcher.dart';
import 'package:freequiz/local_storage/preferences.dart';
import 'package:freequiz/quiz/learning.dart';
import 'package:freequiz/quiz/questionnaire.dart';
import 'package:freequiz/utilities/extensions/context_extensions.dart';
import 'package:freequiz/utilities/widgets/conditional.dart';

class LearningSettings extends StatefulWidget {
  final List<String> languages;
  final String mode;
  const LearningSettings({super.key, required this.languages, required this.mode});

  @override
  State<LearningSettings> createState() => _LearningSettingsState();
}

class _LearningSettingsState extends State<LearningSettings> {
  String answerLanguage = "";
  String maxScore = "";
  String lengthQuestionnaire = "";

  @override
  void initState() {
    answerLanguage = widget.languages[Preferences.answerLanguage];
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
            style: TextStyle(
              fontSize: context.screenHeight / 50,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Switcher(
            onTap: changeAnswerLanguage,
            texts: widget.languages,
            value: answerLanguage,
            width: context.screenWidth - 80,
          ),
          const SizedBox(height: 30),
          Conditional(
            condition: Learning.maxScoreOptions[widget.mode]!.isNotEmpty,
            widget: Text(
              context.tr('amount repetition'),
              style: TextStyle(
                fontSize: context.screenHeight / 50,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Conditional(
            condition: Learning.maxScoreOptions[widget.mode]!.isNotEmpty,
            widget: const SizedBox(height: 5),
          ),
          Conditional(
            condition: Learning.maxScoreOptions[widget.mode]!.isNotEmpty,
            widget: Switcher(
              onTap: changeMaxScore,
              texts: Learning.maxScoreOptions[widget.mode]!,
              value: maxScore,
              width: context.screenWidth - 80,
            ),
          ),
          Conditional(
            condition: Learning.maxScoreOptions[widget.mode]!.isNotEmpty,
            widget: const SizedBox(height: 30),
          ),
          Text(
            context.tr('length round'),
            style: TextStyle(
              fontSize: context.screenHeight / 50,
              fontWeight: FontWeight.bold,
            ),
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
    Preferences.saveAnswerLanguage(widget.languages.indexOf(text));
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
