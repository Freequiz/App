import 'package:easy_localization/easy_localization.dart';
import 'package:freequiz/_home/learning/prompt.dart';
import 'package:freequiz/_views/progress_bar.dart';
import 'package:freequiz/quiz/questionnaire.dart';
import 'package:freequiz/utilities/imports/utilities.dart';

class WritingBody extends StatelessWidget {
  final Function onPressed;
  final bool answerRight;
  final TextEditingController textController;
  final ColorFamily color;
  const WritingBody({
    super.key,
    required this.onPressed,
    required this.answerRight,
    required this.textController,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ProgressBar(
          amount: Questionnaire.length,
          amountLeft: Questionnaire.questions.length.toDouble(),
          color: color
        ),
        Padding(
          padding: const EdgeInsets.only(
              top: 10.0, right: 10.0, left: 10.0, bottom: 10.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextPromt(text: Questionnaire.definition()),
                Space.height(context.screenHeight/ 5),
                Row(
                  children: [
                    Flexible(
                      child: SizedBox(
                        height: context.mobileLayout ? context.screenHeight/ 20 : context.screenHeight/ 30,
                        child: TextField(
                          autocorrect: false,
                          enableSuggestions: false,
                          keyboardType: TextInputType.text,
                          keyboardAppearance:
                              context.darkMode ? Brightness.dark : Brightness.light,
                          controller: textController,
                          onEditingComplete: () {
                            onPressed();
                          },
                          autofocus: true,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: color.light,
                                width: 2.0,
                              ),
                            ),
                            contentPadding: const EdgeInsets.all(10.0),
                            hintText: context.tr('translation'),
                            border: const OutlineInputBorder(),
                            suffixIcon: IconButton(
                              color: color.light,
                              onPressed: () {
                                textController.clear();
                              },
                              icon: const Icon(Icons.clear),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Space.width(5),
                    SizedBox(
                      height: context.mobileLayout ? context.screenHeight/ 20 : context.screenHeight/ 30,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: answerRight ? Colors.green : color.light,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () {
                          onPressed();
                        },
                        child: const Icon(Icons.arrow_forward_ios),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
