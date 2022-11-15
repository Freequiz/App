import 'package:flutter/material.dart';
import 'package:freequiz/_home/subviews/progress_bar.dart';
import 'package:freequiz/_home/quiz.dart';
import 'package:freequiz/others/language.dart';

class WritingBody extends StatelessWidget {
  final Function onPressed;
  final bool answerRight;
  final TextEditingController textController;
  final Color color;
  const WritingBody({
    super.key,
    required this.onPressed,
    required this.answerRight,
    required this.textController,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    final brightness = MediaQuery.of(context).platformBrightness;
    bool darkMode = brightness == Brightness.dark;
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    final bool mobileLayout = shortestSide < 600;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 1.0),
          child: ProgressBar(
            amount: Quiz.amountDefinitions,
            amountLeft: Quiz.indexArray.length,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
              top: 10.0, right: 10.0, left: 10.0, bottom: 10.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  Quiz.definition[Quiz.indexArray[0]],
                  style: TextStyle(fontSize: height / 16),
                ),
                SizedBox(
                  height: height / 5,
                ),
                Row(
                  children: [
                    Flexible(
                      child: SizedBox(
                        height: mobileLayout ? height / 20 : height / 30,
                        child: TextField(
                          autocorrect: false,
                          enableSuggestions: false,
                          keyboardType: TextInputType.name,
                          keyboardAppearance:
                              darkMode ? Brightness.dark : Brightness.light,
                          controller: textController,
                          onEditingComplete: () {
                            onPressed();
                          },
                          autofocus: true,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: color,
                                width: 2.0,
                              ),
                            ),
                            contentPadding: const EdgeInsets.all(10.0),
                            hintText: language["Translation"],
                            border: const OutlineInputBorder(),
                            suffixIcon: IconButton(
                              color: color,
                              onPressed: () {
                                textController.clear();
                              },
                              icon: const Icon(Icons.clear),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    SizedBox(
                      height: mobileLayout ? height / 20 : height / 30,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: answerRight ? Colors.green : color,
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
