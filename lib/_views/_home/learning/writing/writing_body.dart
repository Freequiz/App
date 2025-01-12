import 'package:easy_localization/easy_localization.dart';
import 'package:freequiz/_views/_home/learning/prompt.dart';
import 'package:freequiz/_views/subviews/progress_bar.dart';
import 'package:freequiz/controllers/home/learning/writing.dart';
import 'package:freequiz/controllers/quiz/questionnaire.dart';
import 'package:freequiz/utilities/imports/utilities.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';

class WritingBody extends StatelessWidget {
  final ColorFamily color;
  const WritingBody({
    super.key,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<WritingController>(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ProgressBar(amount: Questionnaire.length, amountLeft: Questionnaire.questions.length.toDouble(), color: color),
        Padding(
          padding: const EdgeInsets.only(top: 10.0, right: 10.0, left: 10.0, bottom: 10.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextPromt(text: Questionnaire.definition()),
                Space.height(context.screenHeight / 5),
                IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Flexible(
                        child: TextField(
                          autocorrect: false,
                          enableSuggestions: false,
                          keyboardType: TextInputType.text,
                          controller: controller.textController,
                          onEditingComplete: () {
                            controller.onPressed(context);
                          },
                          autofocus: true,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: context.darkMode ? color.dark : color.light,
                                width: 3.0,
                              ),
                            ),
                            contentPadding: const EdgeInsets.all(10.0),
                            hintText: context.tr('translation'),
                            border: const OutlineInputBorder(),
                            suffixIcon: IconButton(
                              color: context.darkMode ? color.dark : color.light,
                              onPressed: () {
                                controller.textController.clear();
                              },
                              icon: const Icon(
                                Symbols.close,
                                weight: 700,
                                grade: 200,
                                opticalSize: 24,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Space.width(5),
                      SizedBox(
                        child: TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: context.darkMode
                                ? controller.answerRight
                                    ? greenDark
                                    : color.dark
                                : controller.answerRight
                                    ? greenLight
                                    : color.light,
                            foregroundColor: Colors.white,
                          ),
                          onPressed: () {
                            controller.onPressed(context);
                          },
                          child: const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
