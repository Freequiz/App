import 'package:flutter/material.dart';
import 'package:freequiz/_home/learning/cards/cards.dart';
import 'package:freequiz/_home/learning/multiple_choice/multiple_choice.dart';
import 'package:freequiz/_home/subviews/progress_bar.dart';
import 'package:freequiz/_home/learning/smart.dart';
import 'package:freequiz/_home/learning/writing/writing.dart';
import 'package:freequiz/_home/quiz.dart';
import 'package:freequiz/_home/subviews/word_list.dart';
import 'package:freequiz/others/language.dart';
import 'package:freequiz/others/style.dart';

class StartLearning extends StatefulWidget {
  final int i;
  final Function refresh;
  const StartLearning({super.key, required this.i, required this.refresh});

  @override
  State<StartLearning> createState() => _StartLearningState();
}

class _StartLearningState extends State<StartLearning> {
  final List<Color> color = [color5, color2, color3, color4];
  late final List<Widget> pages = [
    Smart(refresh: refresh),
    Writing(refresh: refresh),
    MultipleChoice(refresh: refresh),
    Cards(refresh: refresh)
  ];
  final List<String> modes = [
    language["Smart"],
    language["Writing"],
    language["Multiple Choice"],
    language["Cards"],
  ];
  final List<String> mode = [
    "Smart",
    "Writing",
    "MultipleChoice",
    "Cards",
  ];
  final List<List> arrays = [
    Quiz.newDefinitions,
    Quiz.learnedDefinitions,
    Quiz.masteredDefinitions
  ];
  final List<String> levels = [
    language["New"],
    language["Learned"],
    language["Mastered"],
  ];

  refresh() {
    Quiz().calculateProgress();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final brightness = MediaQuery.of(context).platformBrightness;
    bool darkMode = brightness == Brightness.dark;
    final color5 = darkMode
        ? const Color.fromARGB(255, 60, 60, 60)
        : const Color.fromARGB(255, 225, 225, 225);
    return Column(
      children: [
        ProgressBar(
            amountLeft: Quiz.answer.length * 2 - Quiz.amountProgress,
            amount: Quiz.answer.length * 2),
        const SizedBox(
          height: 15
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(width / 30.4),
            color: color5,
          ),
          height: height / 10,
          width: width - 20.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  Quiz().formatArray(false);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return pages[widget.i];
                      },
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  height: height / 10 - 20,
                  width: Quiz.marked ? (width - 50) / 2 : width - 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(width / 30.4),
                    color: color[widget.i],
                  ),
                  child: Center(
                    child: Text(
                      language["Learn"],
                      style:
                          TextStyle(fontSize: height / 36, color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
              Quiz.marked
                  ? const SizedBox(
                      width: 10,
                    )
                  : const SizedBox(
                      width: 0,
                    ),
              Quiz.marked
                  ? GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        Quiz().formatArray(true);
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return pages[widget.i];
                            },
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10.0),
                        height: height / 10 - 20,
                        width: (width - 50) / 2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(width / 30.4),
                          color: color[widget.i],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              language["Learn only"],
                              style: TextStyle(
                                  fontSize: height / 36, color: Colors.white, fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              width: 5.0,
                            ),
                            const Icon(
                              Icons.star,
                              color: Colors.white,
                            )
                          ],
                        ),
                      ),
                    )
                  : const SizedBox(
                      width: 0,
                    ),
            ],
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Flexible(
          fit: FlexFit.loose,
          child: Padding(
            padding:
                const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 30.0),
            child: ListView.builder(
              itemCount: 3,
              itemBuilder: (BuildContext context, int i) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    arrays[i].isNotEmpty
                        ? Container(
                            width: (width - 20),
                            height: height / 30,
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Text(
                                levels[i],
                                style: TextStyle(fontSize: height / 40),
                              ),
                            ),
                          )
                        : const SizedBox(
                            height: 0,
                          ),
                    WordList(
                      definitions: Quiz().definitionArray(arrays[i]),
                      answers: Quiz().answerArray(arrays[i]),
                      marked: arrays[i],
                      markWord: markWord,
                      i: i,
                      color: color[widget.i],
                      scrollPhysics: const NeverScrollableScrollPhysics(),
                    ),
                    SizedBox(
                      height: arrays[i].isNotEmpty ? height / 30 : 0,
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  markWord(i, i2) {
    Quiz.markedWords[arrays[i][i2]] = !Quiz.markedWords[arrays[i][i2]];
    Quiz().checkedIfMarkedWords();
    setState(() {
      Quiz().saveMarked("example");
    });
    widget.refresh();
  }
}
