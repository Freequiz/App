import 'package:flutter/material.dart';
import 'package:freequiz/_home/quiz.dart';
import 'package:freequiz/_home/quiz_page/learning_modes.dart';
import 'package:freequiz/_home/quiz_page/word_list.dart';
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
    double height = MediaQuery.of(context).size.height;
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    final bool mobileLayout = shortestSide < 600;
    return Padding(
      padding: mobileLayout
          ? const EdgeInsets.only(
              top: 15.0, bottom: 30.0, left: 10.0, right: 10.0)
          : const EdgeInsets.only(
              top: 20.0, bottom: 20.0, left: 20.0, right: 20.0),
      child: height > width
          ? Column(
              children: [
                SizedBox(
                  height: mobileLayout ? (width - 50) / 4 : (width - 100) / 4,
                  child: LearningModes(
                    scrollDirection: Axis.horizontal,
                    width: mobileLayout ? (width - 50) / 4 : (width - 100) / 4,
                  ),
                ),
                SizedBox(height: mobileLayout ? 15 : 30),
                Expanded(
                  child: WordList(
                    definitions: Quiz.definition,
                    answers: Quiz.answer,
                    marked: const [],
                    markWord: markWord,
                    i: 0,
                    color: color2,
                    scrollPhysics: const ScrollPhysics(),
                    width: width,
                  ),
                ),
              ],
            )
          : Row(
              children: [
                SizedBox(
                  width: (height - 190) / 4,
                  child: LearningModes(
                    width: (height - 190) / 4,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: WordList(
                    definitions: Quiz.definition,
                    answers: Quiz.answer,
                    marked: const [],
                    markWord: markWord,
                    i: 0,
                    color: color2,
                    scrollPhysics: const ScrollPhysics(),
                    width: width - (height - 190) / 4 - 60,
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
