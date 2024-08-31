import 'package:easy_localization/easy_localization.dart';
import 'package:freequiz/_views/_home/learning_page/start_learning_body.dart';
import 'package:freequiz/_views/subviews/alerts/confirmation.dart';
import 'package:freequiz/_views/subviews/alerts/settings.dart';
import 'package:freequiz/controllers/quiz/learning.dart';
import 'package:freequiz/controllers/quiz/progress.dart';
import 'package:freequiz/controllers/quiz/quiz_helper.dart';
import 'package:freequiz/utilities/imports/utilities.dart';

class StartLearning extends StatefulWidget {
  final int i;
  final String uuid;
  final Function refresh;

  const StartLearning({super.key, required this.i, required this.uuid, required this.refresh});

  @override
  State<StartLearning> createState() => _StartLearningState();
}

class _StartLearningState extends State<StartLearning> {

  reset() {
    setState(() {
      Progress.reset(Learning.modes[widget.i], widget.uuid);
    });
  }

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = context.darkMode ? colors[widget.i].dark : colors[widget.i].light;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        foregroundColor: Colors.white,
        scrolledUnderElevation: 0.0,
        title: Text(
          Learning.modes[widget.i].tr(),
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) => Confirmation(
                  reset: reset,
                  i: widget.i,
                ),
              );
            },
            icon: const Icon(Icons.refresh_rounded),
          ),
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) => LearningSettings(
                  languages: [QuizHelper.quiz!.from.name, QuizHelper.quiz!.to.name],
                  mode: Learning.modes[widget.i],
                ),
              );
            },
            icon: const Icon(Icons.settings_rounded),
          ),
          Space.width(10)
        ],
      ),
      body: StartLearningBody(
        i: widget.i,
        refresh: widget.refresh,
        levels: Learning.getLevels(widget.i),
      ),
    );
  }
}
