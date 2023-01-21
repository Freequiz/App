import 'package:flutter/material.dart';
import 'package:freequiz/_home/subviews/progress_bar.dart';
import 'package:freequiz/_home/quiz.dart';
import 'package:freequiz/others/device_info.dart';

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
    final backgroundColor = DeviceInfo.darkMode
        ? const Color.fromARGB(255, 50, 50, 50)
        : const Color.fromARGB(255, 246, 246, 246);
    final foregroundColor = DeviceInfo.darkMode ? Colors.white : Colors.black;
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
                  width: DeviceInfo.width / 1.25,
                  height: DeviceInfo.mobileLayout ? DeviceInfo.height / 4 : DeviceInfo.width / 2.5,
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
                      style: TextStyle(fontSize: DeviceInfo.height / 24),
                    ),
                  ),
                ),
                SizedBox(
                  height: DeviceInfo.height / 16,
                ),
                SizedBox(
                  width: DeviceInfo.width / 1.25,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: DeviceInfo.mobileLayout ? DeviceInfo.width / 5 : DeviceInfo.width / 10,
                        height: DeviceInfo.mobileLayout ? DeviceInfo.width / 5 : DeviceInfo.width / 10,
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
                        width: DeviceInfo.mobileLayout ? DeviceInfo.width / 5 : DeviceInfo.width / 10,
                        height: DeviceInfo.mobileLayout ? DeviceInfo.width / 5 : DeviceInfo.width / 10,
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
                SizedBox(height: DeviceInfo.height / 32),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
