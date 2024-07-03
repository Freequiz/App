import 'package:easy_localization/easy_localization.dart';
import 'package:freequiz/_home/quiz_page/title.dart';
import 'package:freequiz/loading/load_user.dart';
import 'package:freequiz/quiz/quiz_helper.dart';
import 'package:freequiz/utilities/imports/base.dart';

class QuizDescription extends StatelessWidget {
  const QuizDescription({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.darkMode ? gray60 : white235,
        borderRadius: BorderRadius.circular(13),
      ),
      constraints: BoxConstraints(minHeight: context.screenHeight/ 15),
      child: Column(
        children: [
          const QuizTitle(),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 13.0, vertical: 10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: (context.screenWidth - 46) - 42,
                  child: Text(
                    QuizHelper.quiz!.description != ""
                        ? QuizHelper.quiz!.description!
                        : context.tr('no description'),
                    style: fontSize(FontSize.text),
                  ),
                ),
                GestureDetector(
                  onTap: () => loadUser(
                      context: context, user: QuizHelper.quiz!.creator),
                  child: Container(
                    height: 32,
                    width: 32,
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(100),
                      border: Border.all(color: context.darkMode ? Colors.white : gray40, width: 2.0),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.person,
                        size: 24,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
