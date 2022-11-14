import 'package:flutter/material.dart';
import 'package:freequiz/_home/subviews/confirmation.dart';
import 'package:freequiz/_home/quiz.dart';
import 'package:freequiz/_home/start_learning.dart';
import 'package:freequiz/_home/subviews/word_list.dart';
import 'package:freequiz/others/language.dart';
import 'package:freequiz/others/loading_screen.dart';
import 'package:freequiz/others/style.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
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

  refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(
          top: 15.0, bottom: 30.0, left: 10.0, right: 10.0),
      child: Column(
        children: [
          SizedBox(
            height: (width - 50) / 4,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: 4,
              itemBuilder: (BuildContext context, int i) {
                return SizedBox(
                  width: (width - 50) / 4,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: color[i],
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(width / 30.4)),
                    ),
                    onPressed: () async {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return FutureBuilder<void>(
                              future: Quiz().loadData(modes[i], "example"),
                              builder: (context, done) {
                                if (done.connectionState ==
                                    ConnectionState.done) {
                                  return LoadingScreen(
                                    message: "Loading Progress",
                                    finishedLoading: true,
                                    widget: StartLearning(
                                      i: i,
                                      refresh: refresh,
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
                                          child:
                                              const Icon(Icons.refresh_rounded),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                                return LoadingScreen(
                                  message: "Loading Progress",
                                  finishedLoading: false,
                                  widget: StartLearning(
                                    i: i,
                                    refresh: refresh,
                                  ),
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
                      size: width / 8,
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => const SizedBox(
                width: 10,
              ),
            ),
          ),
          const SizedBox(height: 15),
          Expanded(
            child: WordList(
              definitions: Quiz.definition,
              answers: Quiz.answer,
              marked: const [],
              markWord: markWord,
              i: 0,
              color: color2,
              scrollPhysics: const ScrollPhysics(),
            ),
          ),
        ],
      ),
    );
  }

  reset(i) {
    setState(() {
      Quiz().deleteData(modes[i], "example");
      Quiz.newDefinitions.clear();
      Quiz.learnedDefinitions.clear();
      Quiz.masteredDefinitions.clear();
      for (var i = 0; i < Quiz.definition.length; i++) {
        Quiz.newDefinitions.add(i);
      }
    });
  }

  markWord(_, i) {
    Quiz.markedWords[i] = !Quiz.markedWords[i];
    Quiz().checkedIfMarkedWords();
    setState(() {
      Quiz().saveMarked("example");
    });
  }
}
