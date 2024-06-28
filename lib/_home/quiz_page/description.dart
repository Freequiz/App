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
        borderRadius: BorderRadius.circular(context.screenWidth / 30.4),
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
                  width: (context.screenWidth - 46) / 8 * 7,
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
                    height: context.screenHeight/ 35,
                    width: context.screenHeight/ 35,
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(context.screenHeight/ 70),
                      border: Border.all(color: Colors.white, width: 2.0),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.person,
                        size: context.screenHeight/ 45,
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
