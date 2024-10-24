import 'package:easy_localization/easy_localization.dart';
import 'package:freequiz/_views/_home/learning/cards/cards.dart';
import 'package:freequiz/_views/_home/learning/multiple_choice/multiple_choice.dart';
import 'package:freequiz/_views/_home/learning/smart.dart';
import 'package:freequiz/_views/_home/learning/writing/writing.dart';
import 'package:freequiz/controllers/home/learning/smart.dart';
import 'package:freequiz/controllers/quiz/learning.dart';
import 'package:freequiz/controllers/quiz/questionnaire.dart';
import 'package:freequiz/controllers/quiz/quiz_helper.dart';
import 'package:freequiz/utilities/imports/utilities.dart';
import 'package:provider/provider.dart';

class StartLearningButton extends StatelessWidget {
  final int i;
  final Function refresh;
  final String text;
  final IconData? icon;
  final bool onlyMarked;

  const StartLearningButton(
      {super.key, required this.i, required this.refresh, required this.text, this.icon, this.onlyMarked = false});

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      ChangeNotifierProvider(create: (_) => SmartController(), child: const Smart()),
      const Writing(),
      const MultipleChoice(),
      const Cards(),
    ];

    widthButton(width) {
      return QuizHelper.marked ? (context.mobileLayout ? width - 50 : width - 55) / 2 : width - 40;
    }

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Questionnaire.create(onlyMarked, Learning.modes[i]);
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) {
              return pages[i];
            },
          ),
        ).then(
          (context) => Learning.stop(
            refresh,
            QuizHelper.quiz!.id,
            Learning.modes[i],
          ),
        );
      },
      child: Container(
        width: widthButton(context.screenWidth),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(13),
          color: colors[i].medium,
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            context.tr(text),
            style: const TextStyle(fontSize: FontSize.button, color: Colors.white, fontWeight: FontWeight.w600),
          ),
          Visibility(
            visible: icon != null,
            child: const SizedBox(width: 5.0),
          ),
          Visibility(
            visible: icon != null,
            child: Icon(
              icon,
              color: Colors.white,
            ),
          )
        ]),
      ),
    );
  }
}
