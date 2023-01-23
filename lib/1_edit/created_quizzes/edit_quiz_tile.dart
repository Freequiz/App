import 'package:flutter/material.dart';
import 'package:freequiz/1_edit/confirmation.dart';
import 'package:freequiz/1_edit/edit_create_quiz/edit_quiz.dart';
import 'package:freequiz/quiz.dart';
import 'package:freequiz/_home/quiz_page/quiz_page.dart';
import 'package:freequiz/_home/subviews/kebab_menu.dart';
import 'package:freequiz/api/quizzes.dart';
import 'package:freequiz/others/device_info.dart';
import 'package:freequiz/others/initial_loading.dart';
import 'package:freequiz/loading/error_loading/error_loading.dart';
import 'package:freequiz/loading/loading_screen/loading_screen.dart';
import 'package:freequiz/others/style.dart';

class EditQuizTile extends StatefulWidget {
  final Map data;
  final bool expanded;
  final String uuid;
  final Function refresh;
  const EditQuizTile(
      {super.key,
      required this.data,
      required this.uuid,
      this.expanded = true,
      required this.refresh});

  @override
  State<EditQuizTile> createState() => _EditQuizTileState();
}

class _EditQuizTileState extends State<EditQuizTile> {
  final arrow = '\u279C';
  bool expanded = true;
  bool shown = true;

  @override
  void initState() {
    super.initState();
    expanded = widget.expanded;
  }

  show() {
    widget.refresh();
    setState(() {
      shown = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final color6 = DeviceInfo.darkMode
        ? const Color.fromARGB(255, 55, 55, 55)
        : const Color.fromARGB(255, 235, 235, 235);
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        onTap();
      },
      child: shown
          ? Dismissible(
              key: Key(widget.uuid),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) {
                showDialog(
                    context: context,
                    builder: (BuildContext context) =>
                        Confirmation(refresh: show, uuid: widget.uuid));
              },
              background: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(DeviceInfo().height() / 100),
                  color: Colors.red,
                ),
                child: const Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Icon(
                      Icons.delete_forever_rounded,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              child: Container(
                height: DeviceInfo.mobileLayout
                    ? expanded
                        ? DeviceInfo().height() / 30 * 4.5 + 15
                        : DeviceInfo().height() / 30 * 2.5 + 15
                    : expanded
                        ? DeviceInfo().height() / 30 * 4.5 + 35
                        : DeviceInfo().height() / 30 * 2.5 + 35,
                width: DeviceInfo().width() - 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(DeviceInfo().height() / 100),
                  color: color6,
                ),
                child: Padding(
                  padding: DeviceInfo.mobileLayout
                      ? const EdgeInsets.only(
                          left: 10.0, right: 10.0, bottom: 10.0, top: 5.0)
                      : const EdgeInsets.only(
                          left: 20.0, right: 20.0, bottom: 20.0, top: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: DeviceInfo().height() / 20,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.data['title'],
                              style:
                                  TextStyle(fontSize: DeviceInfo().height() / 30),
                            ),
                            GestureDetector(
                              onTap: () {
                                edit();
                              },
                              child: Icon(
                                Icons.edit,
                                color: DeviceInfo.darkMode
                                    ? Colors.white
                                    : textGray,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: expanded
                                ? DeviceInfo().height() / 15
                                : DeviceInfo().height() / 30,
                            width: expanded
                                ? DeviceInfo.mobileLayout
                                    ? DeviceInfo().width() - 40
                                    : DeviceInfo().width() - 60
                                : DeviceInfo.mobileLayout
                                    ? (DeviceInfo().width() - 40) / 6 * 5
                                    : (DeviceInfo().width() - 60) / 6 * 5,
                            child: Text(
                              expanded
                                  ? widget.data['description']
                                  : trim(widget.data['description']),
                              style: TextStyle(
                                  fontSize:
                                      widget.data['description'].length > 50
                                          ? DeviceInfo().height() / 60
                                          : DeviceInfo().height() / 50),
                            ),
                          ),
                          widget.expanded
                              ? const SizedBox(
                                  height: 0,
                                  width: 0,
                                )
                              : SizedBox(
                                  height: DeviceInfo().height() / 30,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        expanded = true;
                                      });
                                    },
                                    child: Text(
                                      expanded ? "" : language["More"],
                                      style: TextStyle(
                                          color: color1,
                                          fontSize: DeviceInfo().height() / 50),
                                    ),
                                  ),
                                ),
                        ],
                      ),
                      expanded
                          ? SizedBox(
                              height: DeviceInfo().height() / 30,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    height: DeviceInfo().height() / 30,
                                    decoration: BoxDecoration(
                                        color: color2,
                                        borderRadius: BorderRadius.circular(
                                            DeviceInfo().height() / 60)),
                                    alignment: Alignment.center,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: DeviceInfo().height() / 60),
                                      child: Text(
                                        "${language["Questions"]} ${widget.data['translations'] ?? widget.data['data'].length}",
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10.0,
                                  ),
                                  Container(
                                    height: DeviceInfo().height() / 30,
                                    decoration: BoxDecoration(
                                        color: color5,
                                        borderRadius: BorderRadius.circular(
                                            DeviceInfo().height() / 60)),
                                    alignment: Alignment.center,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: DeviceInfo().height() / 60),
                                      child: Text(
                                        "${language[widget.data['from']['name']]} $arrow ${language[widget.data['to']['name']]}",
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : const SizedBox(
                              height: 0,
                            ),
                    ],
                  ),
                ),
              ),
            )
          : const SizedBox(
              height: 0,
            ),
    );
  }

  trim(String description) {
    final String trimmedDescription =
        description.characters.take(32).toString();
    if (trimmedDescription.length == widget.data['description'].length) {
      return trimmedDescription;
    }
    return '$trimmedDescription...';
  }

  onTap() {
    final futureMap = APIQuizzes().getQuiz(widget.uuid, false);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return FutureBuilder<Map>(
            future: futureMap,
            builder: (context, quiz) {
              if (quiz.hasData) {
                if (quiz.data!['success']) {
                  Quiz.title = quiz.data!['quiz_data']['title'];
                  return LoadingScreen(
                    message: "Loading Quiz",
                    finishedLoading: true,
                    widget: QuizPage(
                      uuid: widget.uuid,
                    ),
                    appBar: AppBar(
                      title: Text(Quiz.title),
                      actions: [
                        KebabMenuButton(
                          url:
                              "https://freequiz.herokuapp.com/quiz/${widget.uuid}",
                          uuid: widget.uuid,
                        ),
                      ],
                    ),
                  );
                } else {
                  return ErrorLoading(
                    error: quiz.data!["message"],
                  );
                }
              } else if (quiz.hasError) {
                return const ErrorLoading(
                  error: "other error",
                );
              }
              return LoadingScreen(
                message: "Loading Quiz",
                finishedLoading: false,
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

  edit() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return EditQuiz(
            refresh: widget.refresh,
            uuid: widget.uuid,
          );
        },
      ),
    );
  }
}
