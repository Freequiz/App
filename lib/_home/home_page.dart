import 'package:flutter/material.dart';
import 'package:freequiz/_home/quiz.dart';
import 'package:freequiz/_home/subviews/list_quiz.dart';
import 'package:freequiz/others/language.dart';
import 'package:freequiz/others/style.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final textController = TextEditingController();
  late Future<Map> futureMap;
  bool finishedWaiting = false;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final brightness = MediaQuery.of(context).platformBrightness;
    bool darkMode = brightness == Brightness.dark;
    final hintColor = darkMode ? Colors.white : textGray;
    final backgroundColor = darkMode
        ? const Color.fromARGB(255, 55, 55, 55)
        : const Color.fromARGB(255, 235, 235, 235);
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    final bool mobileLayout = shortestSide < 600;
    return Padding(
      padding: EdgeInsets.all(mobileLayout ? 10 : 30),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: mobileLayout ? height / 20 + 20 : 60,
              width: mobileLayout ? width - 20 : width / 2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: backgroundColor,
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Flexible(
                      child: SizedBox(
                        height: mobileLayout ? height / 20 : 40,
                        child: TextField(
                          keyboardAppearance:
                              darkMode ? Brightness.dark : Brightness.light,
                          controller: textController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: darkMode
                                ? const Color.fromARGB(255, 45, 45, 45)
                                : const Color.fromARGB(255, 245, 245, 245),
                            contentPadding: const EdgeInsets.all(10.0),
                            border: const OutlineInputBorder(),
                            hintText: language["Search"],
                            suffixIcon: IconButton(
                              color: hintColor,
                              onPressed: () {
                                textController.clear();
                              },
                              icon: const Icon(
                                Icons.clear,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    SizedBox(
                      height: mobileLayout ? height / 20 : 40,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: color1,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () {},
                        child: const Icon(Icons.search_rounded),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: mobileLayout ? 10 : 30,
            ),
            mobileLayout
                ? const Expanded(
                    child: ListQuiz(),
                  )
                : Quiz().amountUuids() > 1
                    ? Expanded(
                        child: Row(
                          children: const [
                            Expanded(
                              child: ListQuiz(
                                physics: NeverScrollableScrollPhysics(),
                              ),
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            Expanded(
                              child: ListQuiz(
                                physics: NeverScrollableScrollPhysics(),
                                n: 1,
                              ),
                            )
                          ],
                        ),
                      )
                    : Expanded(
                        child: Row(
                          children: [
                            SizedBox(
                              width: (width - 30) / 4 + 15,
                            ),
                            const Expanded(
                              child: ListQuiz(
                                physics: NeverScrollableScrollPhysics(),
                              ),
                            ),
                            SizedBox(
                              width: (width - 30) / 4 + 15,
                            ),
                          ],
                        ),
                      ),
          ],
        ),
      ),
    );
  }
}
