import 'package:easy_localization/easy_localization.dart';
import 'package:freequiz/_views/_home/quiz_page/title.dart';
import 'package:freequiz/_views/subviews/buttons/user.dart';
import 'package:freequiz/controllers/quiz/quiz_helper.dart';
import 'package:freequiz/utilities/imports/utilities.dart';

class QuizDescription extends StatelessWidget {
  const QuizDescription({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.darkMode ? gray60 : white235,
        borderRadius: BorderRadius.circular(13),
      ),
      padding: const EdgeInsets.all(13.0),
      constraints: BoxConstraints(minHeight: context.screenHeight/ 15),
      child: Column(
        children: [
          const QuizTitle(),
          const SizedBox(height: 10.0),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  QuizHelper.quiz!.description != ""
                      ? QuizHelper.quiz!.description!
                      : context.tr('no description'),
                  style: fontSize(FontSize.text),
                ),
              ),
              const LayoutWidget(mobile: SizedBox(width: 5.0)),
              const LayoutWidget(mobile: UserButton())
            ],
          ),
        ],
      ),
    );
  }
}
