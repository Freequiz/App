import 'package:freequiz/_views/_home/learning_page/button.dart';
import 'package:freequiz/controllers/quiz/quiz_helper.dart';
import 'package:freequiz/utilities/imports/utilities.dart';

class StartLearningButtons extends StatefulWidget {
  final int i;
  final Function refresh;

  const StartLearningButtons({super.key, required this.i, required this.refresh});

  @override
  State<StartLearningButtons> createState() => _StartLearningButtonsState();
}

class _StartLearningButtonsState extends State<StartLearningButtons> {
  double width = 0;
  double previousWidth = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.mobileLayout ? context.screenHeight / 12 : 80,
      width: context.screenWidth,
      padding: const EdgeInsets.only(bottom: 20),
      color: context.darkMode ? colors[widget.i].dark : colors[widget.i].light,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          StartLearningButton(i: widget.i, refresh: widget.refresh, text: 'learn'),
          Visibility(
            visible: QuizHelper.marked,
            child: SizedBox(width: context.mobileLayout ? 10 : 15),
          ),
          Visibility(
            visible: QuizHelper.marked,
            child: StartLearningButton(
              i: widget.i,
              refresh: widget.refresh,
              text: 'learn only',
              icon: Icons.star,
              onlyMarked: true,
            ),
          ),
        ],
      ),
    );
  }
}
