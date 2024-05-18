import 'package:flutter/material.dart';
import 'package:freequiz/_home/learning/start_learning.dart';
import 'package:freequiz/_home/subviews/confirmation.dart';
import 'package:freequiz/loading/loading_screen/loading_screen.dart';
import 'package:freequiz/others/string_extensions.dart';
import 'package:freequiz/others/style.dart';
import 'package:freequiz/quiz.dart';

final List<String> modes = [
  "Smart",
  "Writing",
  "MultipleChoice",
  "Cards",
];
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
        return FutureBuilder<void>(
          future: Quiz().loadData(i, uuid),
          builder: (context, done) {
            if (done.connectionState == ConnectionState.done) {
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
                  title: Text(modes[i].transl()),
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
            }
            return LoadingScreen(
              message: "Loading Progress",
              finishedLoading: false,
              appBar: AppBar(
                title: Text("Loading".transl()),
              ),
            );
          },
        );
      },
    ),
  );
}
