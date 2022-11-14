import 'package:flutter/material.dart';
import 'package:freequiz/_home/quiz.dart';
import 'package:freequiz/_home/quiz_page.dart';
import 'package:freequiz/_home/subviews/share.dart';
import 'package:freequiz/api/api.dart';
import 'package:freequiz/others/language.dart';
import 'package:freequiz/others/loading_screen.dart';
import 'package:freequiz/others/style.dart';

class QuizTile extends StatefulWidget {
  final Map data;
  const QuizTile({super.key, required this.data});

  @override
  State<QuizTile> createState() => _QuizTileState();
}

class _QuizTileState extends State<QuizTile> {
  final arrow = '\u279C';

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final brightness = MediaQuery.of(context).platformBrightness;
    bool darkMode = brightness == Brightness.dark;
    final color6 = darkMode
        ? const Color.fromARGB(255, 55, 55, 55)
        : const Color.fromARGB(255, 235, 235, 235);
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        onTap();
      },
      child: Container(
        height: height / 30 * 4.5 + 15,
        width: width - 20,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(height / 100),
          color: color6,
        ),
        child: Padding(
          padding: const EdgeInsets.only(
              left: 10.0, right: 10.0, bottom: 10.0, top: 5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: height / 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.data['title'],
                      style: TextStyle(fontSize: height / 30),
                    ),
                    ShareButton(
                      url: "https://shadowcrafter.org/api/quiz/example/data",
                      color: darkMode ? Colors.white : textGray,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height / 15,
                child: Text(
                  widget.data['description'],
                  style: TextStyle(
                      fontSize: widget.data['description'].length > 50
                          ? height / 60
                          : height / 50),
                ),
              ),
              SizedBox(
                height: height / 30,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: height / 30,
                      decoration: BoxDecoration(
                          color: color2,
                          borderRadius: BorderRadius.circular(height / 60)),
                      alignment: Alignment.center,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: height / 60),
                        child: Text(
                            "${language["Questions"]} ${Quiz.answer.length.toString()}"),
                      ),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Container(
                      height: height / 30,
                      decoration: BoxDecoration(
                          color: color5,
                          borderRadius: BorderRadius.circular(height / 60)),
                      alignment: Alignment.center,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: height / 60),
                        child: Text(
                            "${language[widget.data['from']]} $arrow ${language[widget.data['to']]}"),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  onTap() {
    final futureMap = getQuiz("example");
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return FutureBuilder<Map>(
            future: futureMap,
            builder: (context, quiz) {
              if (quiz.hasData) {
                Quiz.title = quiz.data!['data']['title'];
                return LoadingScreen(
                  message: "Loading Quiz",
                  finishedLoading: true,
                  widget: const QuizPage(),
                  appBar: AppBar(
                    title: Text(Quiz.title),
                    actions: const [
                      ShareButton(
                        url: "https://shadowcrafter.org/api/quiz/example/data",
                        color: Colors.white,
                      ),
                    ],
                  ),
                );
              } else if (quiz.hasError) {
                return Drawer(child: Text('${quiz.error}'));
              }
              return LoadingScreen(
                message: "Loading Quiz",
                finishedLoading: false,
                widget: const QuizPage(),
                appBar: AppBar(
                  title: Text(language["Loading"]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
