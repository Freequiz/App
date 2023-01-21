import 'package:flutter/material.dart';
import 'package:freequiz/_home/home_page/search_page/search_bar.dart';
import 'package:freequiz/_home/quiz.dart';
import 'package:freequiz/_home/home_page/last_quizzes.dart';
import 'package:freequiz/others/device_info.dart';
import 'package:freequiz/others/style.dart';

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
    final opacityColor = DeviceInfo.darkMode ? backgroundGray : Colors.white;
    return Padding(
      padding: EdgeInsets.all(DeviceInfo.mobileLayout ? 10 : 30),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Center(child: SearchBar()),
            SizedBox(
              height: DeviceInfo.mobileLayout ? 10 : 30,
            ),
            Quiz().amountUuids() > 0
                ? DeviceInfo.mobileLayout
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
                                  width: (DeviceInfo.width - 30) / 4 + 15,
                                ),
                                const Expanded(
                                  child: LastQuizzes(
                                    physics: NeverScrollableScrollPhysics(),
                                  ),
                                ),
                                SizedBox(
                                  width: (DeviceInfo.width - 30) / 4 + 15,
                                ),
                              ],
                            ),
                          )
                : Expanded(
                    child: Column(
                      children: [
                        const Spacer(
                          flex: 1,
                        ),
                        SizedBox(
                          width: DeviceInfo.width / 1.25,
                          child: Image.asset(
                            "images/icon_transparent.png",
                            color: opacityColor.withOpacity(0.4),
                            colorBlendMode: BlendMode.modulate,
                          ),
                        ),
                        const Spacer(
                          flex: 2,
                        ),
                      ],
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
