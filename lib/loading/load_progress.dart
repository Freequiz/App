import 'package:flutter/material.dart';
import 'package:freequiz/_home/learning/start_learning.dart';
import 'package:freequiz/_views/learning/confirmation.dart';
import 'package:freequiz/loading/loading_screen/loading_screen.dart';
import 'package:freequiz/others/string_extensions.dart';
import 'package:freequiz/others/style.dart';
import 'package:freequiz/quiz/learning.dart';

final List<String> levelsNormal = [
  "New".transl(),
  "Learned".transl(),
  "Mastered".transl(),
];

final List<String> levelsSmart = [
  "New".transl(),
  "Seen".transl(),
  "Memorized".transl(),
  "Learned".transl(),
  "Mastered".transl()
];
final List<Color> color = [
  purpleFreequiz,
  roseFreequiz,
  yellowFreequiz,
  blueFreequiz,
];

loadProgress(BuildContext context, String uuid, int i, Function reset,
    Function refresh) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (BuildContext context) {
        return LoadingScreen(
          message: "Loading Progress",
          finishedLoading: true,
          widget: StartLearning(
            i: i,
            refresh: refresh,
            levels: i == 0 ? levelsSmart : levelsNormal,
            uuid: uuid,
          ),
          appBar: AppBar(
            backgroundColor: color[i],
            title: Text(Learning.modes[i].transl()),
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
            ],
          ),
        );
      },
    ),
  );
}
