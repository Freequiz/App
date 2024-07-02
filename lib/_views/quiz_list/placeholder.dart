import 'package:easy_localization/easy_localization.dart';
import 'package:freequiz/utilities/imports/base.dart';

class QuizListPlaceholder extends StatelessWidget {
  const QuizListPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    final color6 = context.darkMode ? gray55 : white235;
    return Align(
        alignment: Alignment.topLeft,
        child: Container(
          padding: context.mobileLayout
              ? const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0, top: 3.0)
              : const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15.0, top: 5.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(context.screenHeight / 100),
            color: color6,
          ),
          alignment: Alignment.center,
          width: context.mobileLayout ? context.screenWidth - 100 : 400,
          child: Text(
            context.tr("quizzes will be added here"),
            style: titleStyle(),
          ),
        ),
      );
  }
}