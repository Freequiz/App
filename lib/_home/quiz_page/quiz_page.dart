import 'package:flutter/material.dart';
import 'package:freequiz/_home/quiz_page/search_bar_words.dart';
import 'package:freequiz/quiz.dart';
import 'package:freequiz/_home/quiz_page/learning_modes.dart';
import 'package:freequiz/_home/quiz_page/nothing_found.dart';
import 'package:freequiz/_home/quiz_page/word_list.dart';
import 'package:freequiz/_home/quiz_page/word_list_taskbar.dart';
import 'package:freequiz/others/style.dart';

class QuizPage extends StatefulWidget {
  final String uuid;
  const QuizPage({super.key, required this.uuid});

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

  List shownDefinition = Quiz.definition;
  List shownAnswer = Quiz.answer;

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
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: mobileLayout ? (width - 50) / 4 : (width - 100) / 4,
                  child: LearningModes(
                    scrollDirection: Axis.horizontal,
                    width: mobileLayout ? (width - 50) / 4 : (width - 100) / 4,
                    uuid: widget.uuid,
                  ),
                ),
                SizedBox(height: mobileLayout ? 15 : 30),
                WordListTaskbar(
                  search: search,
                ),
                shownDefinition.isEmpty
                    ? const NothingFound()
                    : Expanded(
                        child: WordList(
                          definitions: shownDefinition,
                          answers: shownAnswer,
                          markWord: markWord,
                          color: color2,
                          width: width,
                          roundedCornersTop: false,
                        ),
                      ),
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: (height - 190) / 4,
                  child: LearningModes(
                    width: (height - 190) / 4,
                    uuid: widget.uuid,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    children: [
                      SearchBarWords(
                        search: search,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      WordList(
                        definitions: shownDefinition,
                        answers: shownAnswer,
                        markWord: markWord,
                        color: color2,
                        width: width - (height - 190) / 4 - 60,
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  search(String searchTerm) {
    shownDefinition = [];
    shownAnswer = [];
    for (var i = 0; i < Quiz.definition.length; i++) {
      final definition = Quiz.definition[i];
      final answer = Quiz.answer[i];
      if (definition.contains(searchTerm)) {
        shownDefinition.add(definition);
        shownAnswer.add(answer);
      } else if (answer.contains(searchTerm)) {
        shownDefinition.add(definition);
        shownAnswer.add(answer);
      }
    }
    setState(() {});
  }

  markWord(_, i) {
    if (Quiz.markedWords[i]) {
      Quiz.markedWords[i] = !Quiz.markedWords[i];
      Quiz().checkedIfMarkedWords();
      setState(() {
        Quiz().saveMarked(
            widget.uuid, "", Quiz.mapQuiz['quiz_data']['data'][i]['hash']);
      });
    } else {
      Quiz.markedWords[i] = !Quiz.markedWords[i];
      Quiz().checkedIfMarkedWords();
      setState(() {
        Quiz().saveMarked(
            widget.uuid, Quiz.mapQuiz['quiz_data']['data'][i]['hash'], "");
      });
    }
  }
}
