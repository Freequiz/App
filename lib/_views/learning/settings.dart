import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:freequiz/_views/switcher/switcher.dart';
import 'package:freequiz/local_storage/preferences.dart';
import 'package:freequiz/others/device_info.dart';
import 'package:freequiz/others/utilities.dart';
import 'package:freequiz/quiz/learning.dart';

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

  @override
  void initState() {
    answerLanguage = widget.languages[Preferences.answerLanguage];
    maxScore = Preferences.maxScores[widget.mode].toString();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final brightness = MediaQuery.of(context).platformBrightness;
    bool darkMode = brightness == Brightness.dark;
    return AlertDialog(
      title: Text(
        context.tr('settings'),
        style: TextStyle(color: darkMode ? Colors.white : Colors.black),
      ),
      insetPadding: const EdgeInsets.all(20.0),
      contentPadding: const EdgeInsets.all(20.0),
      content: Column(
        children: [
          const SizedBox(height: 20),
          Text(
            context.tr('answer with'),
            style: TextStyle(
              fontSize: DeviceInfo().height() / 50,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Switcher(
            onTap: changeAnswerLanguage,
            texts: widget.languages,
            value: answerLanguage,
            width: DeviceInfo().width() - 80,
          ),
          const SizedBox(height: 30),
          conditional(
            Learning.maxScoreOptions[widget.mode]!.isNotEmpty,
            Text(
              context.tr('amount repetition'),
              style: TextStyle(
                fontSize: DeviceInfo().height() / 50,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          conditional(
            Learning.maxScoreOptions[widget.mode]!.isNotEmpty,
            const SizedBox(height: 5),
          ),
          conditional(
            Learning.maxScoreOptions[widget.mode]!.isNotEmpty,
            Switcher(
              onTap: changeMaxScore,
              texts: Learning.maxScoreOptions[widget.mode]!,
              value: maxScore,
              width: DeviceInfo().width() - 80,
            ),
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
}
