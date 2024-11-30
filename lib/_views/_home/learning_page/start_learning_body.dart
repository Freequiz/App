import 'package:freequiz/_views/_home/learning_page/buttons.dart';
import 'package:freequiz/_views/subviews/progress_bar.dart';
import 'package:freequiz/models/translation.dart';
import 'package:freequiz/controllers/quiz/quiz_helper.dart';
import 'package:freequiz/_views/subviews/word_list/word_list.dart';
import 'package:freequiz/controllers/quiz/learning.dart';
import 'package:freequiz/controllers/quiz/progress.dart';
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
          amountLeft: QuizHelper.quiz!.length() - Progress.amount,
          amount: QuizHelper.quiz!.length(),
          color: colors[widget.i],
        ),
        StartLearningButtons(i: widget.i, refresh: refresh),
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
                    Visibility(
                      visible: progressArray.isNotEmpty,
                      child: Container(
                        padding: EdgeInsets.all(
                          context.mobileLayout ? 13 : context.screenHeight / 80,
                        ),
                        width: context.screenWidth,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(13),
                            topRight: Radius.circular(13),
                          ),
                          color: context.darkMode ? colors[widget.i].dark : colors[widget.i].light,
                        ),
                        child: Text(
                          i < widget.levels.length ? widget.levels[i] : widget.levels.last,
                          style: const TextStyle(
                            fontSize: FontSize.title,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
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
