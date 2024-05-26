import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:freequiz/_home/learning/start_learning.dart';
import 'package:freequiz/_views/learning/confirmation.dart';
import 'package:freequiz/_views/learning/settings.dart';
import 'package:freequiz/loading/loading_screen/loading_screen.dart';
import 'package:freequiz/others/style.dart';
import 'package:freequiz/quiz/learning.dart';
import 'package:freequiz/quiz/quiz_helper.dart';


final List<Color> color = [
  purpleFreequiz,
  roseFreequiz,
  yellowFreequiz,
  blueFreequiz,
];

//TODO: Fix this shit

loadProgress(BuildContext context, String uuid, int i, Function reset,
    Function refresh) {
  if (QuizHelper.quiz!.translations.translations.isEmpty) return;
  
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (BuildContext context) {
        return LoadingScreen(
          message: "Loading Progress",
          finishedLoading: true,
          widget: StartLearning(
            i: i,
            refresh: refresh,
            levels: Learning.getLevels(i),
            uuid: uuid,
          ),
          appBar: AppBar(
            backgroundColor: color[i],
            title: Text(Learning.modes[i].tr()),
            actions: [
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => Confirmation(
                      reset: reset,
                      i: i,
                    ),
                  );
                },
                child: const Icon(Icons.refresh_rounded),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => LearningSettings(
                      languages: [QuizHelper.quiz!.from.name, QuizHelper.quiz!.to.name],
                      mode: Learning.modes[i]
                    ),
                  );
                },
                child: const Icon(Icons.settings_rounded),
              ),
            ],
          ),
        );
      },
    ),
  );
}
