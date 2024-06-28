import 'package:freequiz/_home/quiz_page/description.dart';
import 'package:freequiz/_home/quiz_page/search_bar_words.dart';
import 'package:freequiz/models/translation.dart';
import 'package:freequiz/quiz/quiz_helper.dart';
import 'package:freequiz/_home/quiz_page/learning_modes.dart';
import 'package:freequiz/_views/word_list/nothing_found.dart';
import 'package:freequiz/_views/word_list/word_list.dart';
import 'package:freequiz/_views/word_list/word_list_taskbar.dart';
import 'package:freequiz/utilities/imports/utilities.dart';


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
    purpleLight,
    roseLight,
    beigeLight,
    blueLight
  ];

  refresh() {
    setState(() {});
  }

  List<Translation> list = QuizHelper.quiz!.translations.translations.toList();

  @override
  Widget build(BuildContext context) {
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    final bool mobileLayout = shortestSide < 600;
    return Conditional(
      condition: !context.landscape,
      widget: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          LearningModes(
            scrollDirection: Axis.horizontal,
            uuid: widget.uuid,
          ),
          SizedBox(height: mobileLayout ? 15 : 30),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
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
                          color: roseLight,
                          width: context.screenWidth,
                          scrollPhysics: const NeverScrollableScrollPhysics(),
                          roundedCornersTop: false,
                        ),
                ],
              ),
            ),
          ),
        ],
      ),
      defaultWidget: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LearningModes(
            uuid: widget.uuid,
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              children: [
                Text(
                  QuizHelper.quiz!.title,
                  style: const TextStyle(
                    fontSize: FontSize.text,
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
                  color: roseLight,
                  width: context.screenWidth - (context.screenHeight - 190) / 4 - 60,
                ),
              ],
            ),
          ),
        ],
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
