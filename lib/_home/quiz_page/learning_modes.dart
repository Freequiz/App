import 'package:flutter/material.dart';
import 'package:freequiz/_home/quiz.dart';
import 'package:freequiz/_home/learning/start_learning.dart';
import 'package:freequiz/_home/subviews/confirmation.dart';
import 'package:freequiz/others/initial_loading.dart';
import 'package:freequiz/others/loading_screen/loading_screen.dart';
import 'package:freequiz/others/style.dart';

class LearningModes extends StatefulWidget {
  final Axis scrollDirection;
  final double width;
  final String uuid;
  const LearningModes(
      {super.key, this.scrollDirection = Axis.vertical, required this.width, required this.uuid});

  @override
  State<LearningModes> createState() => _LearningModesState();
}

class _LearningModesState extends State<LearningModes> {
  final List<IconData> icon = const [
    Icons.star_border_rounded,
    Icons.keyboard_alt_outlined,
    Icons.format_list_bulleted_rounded,
    Icons.quiz_outlined
  ];
  final List<Color> color = [color5, color2, color3, color4];
  final List<String> modes = [
    "Smart",
    "Writing",
    "MultipleChoice",
    "Cards",
  ];
  final List<String> levelsNormal = [
    language["New"],
    language["Learned"],
    language["Mastered"],
  ];

  final List<String> levelsSmart = [
    language["New"],
    language["Seen"],
    language["Memorized"],
    language["Learned"],
    language["Mastered"]
  ];

  refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    final bool mobileLayout = shortestSide < 600;
    return ListView.separated(
      scrollDirection: widget.scrollDirection,
      itemCount: 4,
      itemBuilder: (BuildContext context, int i) {
        return SizedBox(
          width: widget.width,
          height: widget.width,
          child: TextButton(
            style: TextButton.styleFrom(
              backgroundColor: color[i],
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(widget.width / 7)),
            ),
            onPressed: () async {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return FutureBuilder<void>(
                      future: Quiz().loadData(i, widget.uuid),
                      builder: (context, done) {
                        if (done.connectionState == ConnectionState.done) {
                          return LoadingScreen(
                            message: "Loading Progress",
                            finishedLoading: true,
                            widget: StartLearning(
                              i: i,
                              refresh: refresh,
                              levels: i == 0 ? levelsSmart : levelsNormal,
                              uuid: widget.uuid,
                            ),
                            appBar: AppBar(
                              backgroundColor: color[i],
                              title: Text(language[modes[i]]),
                              actions: [
                                TextButton(
                                  style: TextButton.styleFrom(
                                    foregroundColor: Colors.white,
                                  ),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          Confirmation(
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
                            title: Text(language["Loading"]),
                          ),
                        );
                      },
                    );
                  },
                ),
              );
            },
            child: Icon(
              icon[i],
              size: widget.width / 2,
            ),
          ),
        );
      },
      separatorBuilder: (context, index) => SizedBox(
        width: mobileLayout ? 10 : 20,
        height: mobileLayout ? 10 : 20,
      ),
    );
  }

  reset(i) {
    setState(() {
      Quiz().deleteData(modes[i], "example");
      Quiz.progressArray = [[], [], [], [], [], [], [], [], [], [], [], [], [], [], [], []];
      for (var i = 0; i < Quiz.definition.length; i++) {
        Quiz.progressArray[0].add(i);
      }
    });
  }
}
