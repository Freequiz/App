import 'package:flutter/material.dart';
import 'package:freequiz/_home/subviews/progress_bar.dart';
import 'package:freequiz/_home/quiz.dart';

class CardsBody extends StatelessWidget {
  final Function wrong;
  final Function right;
  final Function changeShowAnswer;
  final bool showAnswer;
  final Color color;
  const CardsBody({
    super.key,
    required this.wrong,
    required this.right,
    required this.changeShowAnswer,
    required this.showAnswer,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final brightness = MediaQuery.of(context).platformBrightness;
    bool darkMode = brightness == Brightness.dark;
    final backgroundColor = darkMode
        ? const Color.fromARGB(255, 50, 50, 50)
        : const Color.fromARGB(255, 246, 246, 246);
    final foregroundColor = darkMode ? Colors.white : Colors.black;
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
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: width / 1.25,
                  height: height / 4,
                  child: ElevatedButton(
                    style: TextButton.styleFrom(
                      backgroundColor: backgroundColor,
                      foregroundColor: foregroundColor,
                    ),
                    onPressed: () {
                      changeShowAnswer();
                    },
                    child: Text(
                      showAnswer
                          ? Quiz.answer[Quiz.indexArray[0]]
                          : Quiz.definition[Quiz.indexArray[0]],
                      style: TextStyle(fontSize: height / 24),
                    ),
                  ),
                ),
                SizedBox(
                  height: height / 16,
                ),
                SizedBox(
                  width: width / 1.25,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: width / 5,
                        height: width / 5,
                        child: FloatingActionButton(
                          heroTag: "wrong",
                          onPressed: () {
                            wrong();
                          },
                          backgroundColor: Colors.red,
                          child: const Icon(Icons.close),
                        ),
                      ),
                      SizedBox(
                        width: width / 5,
                        height: width / 5,
                        child: FloatingActionButton(
                          heroTag: "right",
                          onPressed: () {
                            right();
                          },
                          backgroundColor: Colors.green,
                          child: const Icon(Icons.check),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: height / 32),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
