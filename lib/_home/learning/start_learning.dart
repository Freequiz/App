import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:freequiz/_home/learning/start_learning_body.dart';
import 'package:freequiz/_views/alerts/confirmation.dart';
import 'package:freequiz/_views/alerts/settings.dart';
import 'package:freequiz/others/style.dart';
import 'package:freequiz/quiz/learning.dart';
import 'package:freequiz/quiz/progress.dart';
import 'package:freequiz/quiz/quiz_helper.dart';

class StartLearning extends StatefulWidget {
  final int i;
  final String uuid;
  final Function refresh;

  const StartLearning({super.key, required this.i, required this.uuid, required this.refresh});

  @override
  State<StartLearning> createState() => _StartLearningState();
}

class _StartLearningState extends State<StartLearning> {
  final List<Color> color = [
    purpleFreequiz,
    roseFreequiz,
    yellowFreequiz,
    blueFreequiz,
  ];

  reset() {
    setState(() {
      Progress.reset(Learning.modes[widget.i], widget.uuid);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: color[widget.i],
        title: Text(Learning.modes[widget.i].tr()),
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
                  i: widget.i,
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
                  mode: Learning.modes[widget.i],
                ),
              );
            },
            child: const Icon(Icons.settings_rounded),
          ),
        ],
      ),
      body: StartLearningBody(
        i: widget.i,
        refresh: widget.refresh,
        levels: Learning.getLevels(widget.i),
        uuid: widget.uuid,
      ),
    );
  }
}
