import 'package:flutter/material.dart';
import 'package:freequiz/_home/quiz_tile.dart';
import 'package:freequiz/api/api.dart';
import 'package:freequiz/_home/quiz.dart';
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
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Column(
          children: [
            Container(
              height: height / 20 + 20,
              width: width - 20,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(height / 100),
                color: backgroundColor,
              ),
              child: Padding(
                padding: EdgeInsets.all(height / 100),
                child: Row(
                  children: [
                    Flexible(
                      child: SizedBox(
                        height: height / 20,
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
                      height: height / 20,
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
              height: height / 60,
            ),
            Expanded(
              child: ListView.separated(
                itemCount: Quiz().amountUuids(),
                itemBuilder: (BuildContext context, int i) {
                  futureMap = getQuiz(Quiz.uuids[i]);
                  return FutureBuilder<Map>(
                    future: futureMap,
                    builder: (context, quiz) {
                      if (quiz.hasData) {
                        Quiz.title = quiz.data!['data']['title'];
                        return QuizTile(
                          data: quiz.data!['data'],
                        );
                      } else if (quiz.hasError) {
                        return Drawer(child: Text('${quiz.error}'));
                      }
                      return const CircularProgressIndicator();
                    },
                  );
                },
                separatorBuilder: (BuildContext context, int i) {
                  return SizedBox(
                    height: height / 60,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
