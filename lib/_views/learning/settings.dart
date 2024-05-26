import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:freequiz/_views/switcher/switcher.dart';
import 'package:freequiz/local_storage/preferences.dart';
import 'package:freequiz/others/device_info.dart';

class LearningSettings extends StatefulWidget {
  final List<String> languages;
  const LearningSettings({super.key, required this.languages});

  @override
  State<LearningSettings> createState() => _LearningSettingsState();
}

class _LearningSettingsState extends State<LearningSettings> {
  List<String> options = [];

  String value = "";

  @override
  void initState() {
    options = widget.languages;
    options.add('both');
    value = options[Preferences.answerLanguage];

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
          const SizedBox(height: 20,),
          Text(
            context.tr('answer with'),
            style: TextStyle(
              fontSize: DeviceInfo().height() / 50,
              fontWeight: FontWeight.bold,
            ),
          ),
          Switcher(
            onTap: onTap,
            texts: options,
            value: value,
            width: DeviceInfo().width() - 80,
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

  onTap(String text) {
    Preferences.saveAnswerLanguage(options.indexOf(text));
    setState(() {
      value = text;
    });
  }
}
