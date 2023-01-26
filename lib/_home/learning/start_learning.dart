import 'package:flutter/material.dart';
import 'package:freequiz/_home/learning/cards/cards.dart';
import 'package:freequiz/_home/learning/multiple_choice/multiple_choice.dart';
import 'package:freequiz/_home/subviews/progress_bar.dart';
import 'package:freequiz/_home/learning/smart.dart';
import 'package:freequiz/_home/learning/writing/writing.dart';
import 'package:freequiz/others/string_extensions.dart';
import 'package:freequiz/quiz.dart';
import 'package:freequiz/_home/quiz_page/word_list/word_list.dart';
import 'package:freequiz/others/device_info.dart';
import 'package:freequiz/others/initial_loading.dart';
import 'package:freequiz/others/style.dart';

class StartLearning extends StatefulWidget {
  final int i;
  final Function refresh;
  final List<String> levels;
  final String uuid;
  const StartLearning(
      {super.key,
      required this.i,
      required this.refresh,
      required this.levels,
      required this.uuid});

  @override
  State<StartLearning> createState() => _StartLearningState();
}

class _StartLearningState extends State<StartLearning> {
  final List<Color> color = [color5, color2, color3, color4];
  late final List<Widget> pages = [
    Smart(refresh: refresh, uuid: widget.uuid,),
    Writing(refresh: refresh, uuid: widget.uuid),
    MultipleChoice(refresh: refresh, uuid: widget.uuid),
    Cards(refresh: refresh, uuid: widget.uuid)
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

  refresh() {
    Quiz().calculateProgress(widget.i);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    final color5 = DeviceInfo.darkMode
        ? const Color.fromARGB(255, 60, 60, 60)
        : const Color.fromARGB(255, 225, 225, 225);
    return Column(
      children: [
        ProgressBar(
            amountLeft: Quiz.answer.length * (widget.i == 0 ? 4 : 2) -
                Quiz.amountProgress,
            amount: Quiz.answer.length * (widget.i == 0 ? 4 : 2)),
        const SizedBox(height: 15),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(DeviceInfo().width() / 30 + 10),
            color: color5,
          ),
          height: DeviceInfo().height() / 10,
          width: DeviceInfo().width() - 20.0,
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
                  height: DeviceInfo().height() / 10 - 20,
                  width: widthStartButton(DeviceInfo().width()),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(DeviceInfo().width() / 30),
                    color: color[widget.i],
                  ),
                  child: Center(
                    child: Text(
                      language["Learn"],
                      style: TextStyle(
                          fontSize: DeviceInfo().height() / 36,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
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
                        height: DeviceInfo().height() / 10 - 20,
                        width: widthStartButton(DeviceInfo().width()),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(DeviceInfo().width() / 30),
                          color: color[widget.i],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Learn only".transl(),
                              style: TextStyle(
                                  fontSize: DeviceInfo().height() / 36,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
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
              itemCount: widget.i == 0 ? 5 : 3,
              itemBuilder: (BuildContext context, int i) {
                debugPrint(i.toString());
                debugPrint(widget.levels[i]);
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    progressArray(widget.i, i).isNotEmpty
                        ? Container(
                            width: (DeviceInfo().width() - 20),
                            height: DeviceInfo().height() / 30,
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Text(
                                widget.levels[i],
                                style: TextStyle(fontSize: DeviceInfo().height() / 40),
                              ),
                            ),
                          )
                        : const SizedBox(
                            height: 0,
                          ),
                    WordList(
                      definitions: defintions(widget.i, i),
                      answers: answers(widget.i, i),
                      marked: progressArray(widget.i, i),
                      markWord: markWord,
                      i: i,
                      color: color[widget.i],
                      scrollPhysics: const NeverScrollableScrollPhysics(),
                      width: DeviceInfo().width(),
                    ),
                    SizedBox(
                      height: progressArray(widget.i, i).isNotEmpty
                          ? DeviceInfo().height() / 30
                          : 0,
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

  widthStartButton(width) {
    return Quiz.marked ? (width - 50) / 2 : width - 40;
  }

  markWord(i, i2) {
    if (Quiz.markedWords[Quiz.progressArray[i][i2]]) {
      Quiz.markedWords[Quiz.progressArray[i][i2]] =
          !Quiz.markedWords[Quiz.progressArray[i][i2]];
      Quiz().checkedIfMarkedWords();
      setState(() {
        Quiz().saveMarked(widget.uuid, "", Quiz.mapQuiz['quiz_data']['data'][i]['hash']);
      });
    } else {
      Quiz.markedWords[Quiz.progressArray[i][i2]] =
          !Quiz.markedWords[Quiz.progressArray[i][i2]];
      Quiz().checkedIfMarkedWords();
      setState(() {
        Quiz().saveMarked(widget.uuid, Quiz.mapQuiz['quiz_data']['data'][i]['hash'], "");
      });
    }
    widget.refresh();
  }

  defintions(int mode, int i) {
    return Quiz().definitionArray(progressArray(mode, i));
  }

  answers(int mode, int i) {
    return Quiz().answerArray(progressArray(mode, i));
  }

  progressArray(int mode, int i) {
    if (mode == 0) {
      if (i == 4) {
        var progressArray = [];
        for (var n = 4; n < Quiz.progressArray.length; n++) {
          progressArray += Quiz.progressArray[n];
        }
        return progressArray;
      }
      return Quiz.progressArray[i];
    }
    return Quiz.progressArray[i];
  }
}
