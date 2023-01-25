import 'package:flutter/material.dart';
import 'package:freequiz/loading/loading.dart';
import 'package:freequiz/others/string_extensions.dart';
import 'package:freequiz/quiz.dart';
import 'package:freequiz/_home/quiz_page/quiz_page.dart';
import 'package:freequiz/_home/subviews/kebab_menu.dart';
import 'package:freequiz/api/quizzes.dart';
import 'package:freequiz/others/device_info.dart';
import 'package:freequiz/loading/error_loading/error_loading.dart';
import 'package:freequiz/others/initial_loading.dart';
import 'package:freequiz/loading/loading_screen/loading_screen.dart';
import 'package:freequiz/others/style.dart';
import 'package:share_plus/share_plus.dart';

class QuizTile extends StatefulWidget {
  final Map data;
  final bool expanded;
  final String uuid;
  final double width;
  const QuizTile(
      {super.key,
      required this.data,
      required this.uuid,
      this.expanded = true,
      required this.width});

  @override
  State<QuizTile> createState() => _QuizTileState();
}

class _QuizTileState extends State<QuizTile> {
  final arrow = '\u279C';
  bool expanded = true;

  @override
  void initState() {
    super.initState();
    expanded = widget.expanded;
  }

  @override
  Widget build(BuildContext context) {
    final color6 = DeviceInfo.darkMode
        ? const Color.fromARGB(255, 55, 55, 55)
        : const Color.fromARGB(255, 235, 235, 235);
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: 
        load(context: context, uuid: widget.uuid),
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
                      style: TextStyle(fontSize: DeviceInfo().height() / 30),
                    ),
                    GestureDetector(
                      onTap: () {
                        Share.share(
                            "https://freequiz.herokuapp.com/quiz/${widget.uuid}");
                      },
                      child: Icon(
                        Icons.ios_share,
                        color: DeviceInfo.darkMode ? Colors.white : textGray,
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
                            ? widget.width - 20
                            : widget.width - 40
                        : DeviceInfo.mobileLayout
                            ? widget.width / 6 * 5 - 20
                            : widget.width / 6 * 5 - 40,
                    child: Text(
                      expanded
                          ? widget.data['description']
                          : trim(widget.data['description']),
                      style: TextStyle(
                          fontSize: widget.data['description'].length > 50
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
                              expanded ? "" : "More".transl(),
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: DeviceInfo().height ()/ 30,
                            decoration: BoxDecoration(
                                color: color2,
                                borderRadius: BorderRadius.circular(
                                    DeviceInfo().height() / 60)),
                            alignment: Alignment.center,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: DeviceInfo().height() / 60),
                              child: Text(
                                "${"Questions".transl()} ${widget.data['translations'] ?? widget.data['data'].length}",
                                style: const TextStyle(color: Colors.white),
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
                                "",
                                style: const TextStyle(color: Colors.white),
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
}