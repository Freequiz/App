import 'package:freequiz/_home/learning_page/button.dart';
import 'package:freequiz/_views/progress_bar.dart';
import 'package:freequiz/models/translation.dart';
import 'package:freequiz/quiz/quiz_helper.dart';
import 'package:freequiz/_views/word_list/word_list.dart';
import 'package:freequiz/quiz/learning.dart';
import 'package:freequiz/quiz/progress.dart';
import 'package:freequiz/utilities/imports/utilities.dart';

class StartLearningBody extends StatefulWidget {
  final int i;
  final Function refresh;
  final List<String> levels;
  const StartLearningBody({super.key, required this.i, required this.refresh, required this.levels});

  @override
  State<StartLearningBody> createState() => _StartLearningBodyState();
}

class _StartLearningBodyState extends State<StartLearningBody> {
  refresh() {
    Progress.calculate(Learning.modes[widget.i]);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Progress.calculate(Learning.modes[widget.i]);
    return Column(
      children: [
        ProgressBar(
          amountLeft: QuizHelper.quiz!.translations.translations.length - Progress.amount,
          amount: QuizHelper.quiz!.translations.translations.length,
          color: colors[widget.i],
        ),
        StartLearningButton(i: widget.i, refresh: refresh),
        Space.height(15),
        Flexible(
          fit: FlexFit.loose,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: ListView.builder(
              itemCount: widget.i == 0 ? 5 : 3,
              itemBuilder: (BuildContext context, int i) {
                final progressArray = Progress.array(Learning.modes[widget.i], i);
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Conditional(
                      condition: progressArray.isNotEmpty,
                      widget: Container(
                        padding: EdgeInsets.all(
                          context.mobileLayout ? 13 : context.screenHeight / 80,
                        ),
                        width: context.screenWidth,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(context.screenWidth / 30.4),
                            topRight: Radius.circular(context.screenWidth / 30.4),
                          ),
                          color: context.darkMode ? colors[widget.i].dark : colors[widget.i].light,
                        ),
                        child: Text(
                              i < widget.levels.length ? widget.levels[i] : widget.levels.last,
                              style: TextStyle(fontSize: context.screenHeight / 40),
                            ),
                      ),
                    ),
                    WordList(
                      list: progressArray,
                      markWord: markWord,
                      i: i,
                      color: colors[widget.i].medium,
                      scrollPhysics: const NeverScrollableScrollPhysics(),
                      roundedCornersTop: false,
                      width: context.screenWidth,
                    ),
                    Space.height(
                      progressArray.isNotEmpty ? context.screenHeight / 30 : 0,
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

  markWord(Translation translation) {
    setState(() {
      translation.toggleFavorite();
    });
    QuizHelper.checkedIfMarkedWords();
    widget.refresh();
  }
}
