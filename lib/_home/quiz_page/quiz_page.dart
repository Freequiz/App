import 'package:flutter/material.dart';
import 'package:freequiz/_home/quiz_page/description.dart';
import 'package:freequiz/_home/quiz_page/search_bar_words.dart';
import 'package:freequiz/models/translation.dart';
import 'package:freequiz/others/device_info.dart';
import 'package:freequiz/quiz/quiz_helper.dart';
import 'package:freequiz/_home/quiz_page/learning_modes.dart';
import 'package:freequiz/_home/quiz_page/word_list/nothing_found.dart';
import 'package:freequiz/_home/quiz_page/word_list/word_list.dart';
import 'package:freequiz/_home/quiz_page/word_list/word_list_taskbar.dart';
import 'package:freequiz/others/style.dart';
import 'package:freequiz/utilities/conditional.dart';


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
  final List<Color> color = [
    purpleFreequiz,
    roseFreequiz,
    yellowFreequiz,
    blueFreequiz
  ];

  refresh() {
    setState(() {});
  }

  List<Translation> list = QuizHelper.quiz!.translations.translations.toList();

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
      child: Conditional(
        condition: height > width,
        widget: Column(
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
            Expanded(
              child: ListView(
                children: [
                  const QuizDescription(),
                  SizedBox(height: mobileLayout ? 15 : 30),
                  WordListTaskbar(
                    search: search,
                  ),
                  list.isEmpty
                      ? const NothingFound()
                      : WordList(
                          list: list,
                          markWord: markWord,
                          color: roseFreequiz,
                          width: width,
                          scrollPhysics: const NeverScrollableScrollPhysics(),
                          roundedCornersTop: false,
                        ),
                ],
              ),
            ),
          ],
        ),
        defaultWidget: Row(
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
                  Text(
                    QuizHelper.quiz!.title,
                    style: TextStyle(
                      fontSize: DeviceInfo().height() / 40,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SearchBarWords(
                    search: search,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  WordList(
                    list: list,
                    markWord: markWord,
                    color: roseFreequiz,
                    width: width - (height - 190) / 4 - 60,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  search(String searchTerm) {
    list.clear();

    for (Translation translation
        in QuizHelper.quiz!.translations.translations) {
      if (translation.word.toLowerCase().contains(searchTerm.toLowerCase())) {
        list.add(translation);
        continue;
      }
      if (translation.translation.toLowerCase().contains(searchTerm.toLowerCase())) {
        list.add(translation);
      }
    }
    setState(() {});
  }

  markWord(Translation translation) {
    setState(() {
      translation.toggleFavorite();
    });
    QuizHelper.checkedIfMarkedWords();
  }
}
