import 'package:flutter/material.dart';
import 'package:freequiz/_home/home_page/search_page/search_bar.dart';
import 'package:freequiz/_home/quiz.dart';
import 'package:freequiz/_home/home_page/last_quizzes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<Map> futureMap;
  bool finishedWaiting = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
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
            const SearchBar(),
            SizedBox(
              height: mobileLayout ? 10 : 30,
            ),
            mobileLayout
                ? const Expanded(
                    child: LastQuizzes(),
                  )
                : Quiz().amountUuids() > 1
                    ? Expanded(
                        child: Row(
                          children: const [
                            Expanded(
                              child: LastQuizzes(
                                physics: NeverScrollableScrollPhysics(),
                              ),
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            Expanded(
                              child: LastQuizzes(
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
                              child: LastQuizzes(
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
