import 'package:flutter/material.dart';
import 'package:freequiz/loading/load_quiz.dart';
import 'package:freequiz/others/string_extensions.dart';
import 'package:freequiz/others/device_info.dart';
import 'package:freequiz/others/style.dart';
import 'package:share_plus/share_plus.dart';

import '../../others/utilities.dart';

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
      onTap: () => loadQuiz(
        context: context,
        uuid: widget.uuid,
      ),
      child: Container(
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
                    shareButton()
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [description(), moreButton()],
              ),
              expanded
                  ? Container(
                      padding: const EdgeInsets.only(top: 15),
                      height: DeviceInfo().height() / 30 + 15,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          numberOfTranslations(),
                          const SizedBox(
                            width: 10.0,
                          ),
                          infoLanguage()
                        ],
                      ),
                    )
                  : empty()
            ],
          ),
        ),
      ),
    );
  }

  Widget shareButton() {
    return GestureDetector(
      onTap: () {
        Share.share("https://www.freequiz.ch/quiz/${widget.uuid}");
      },
      child: Icon(
        Icons.ios_share,
        color: DeviceInfo.darkMode ? Colors.white : textGray,
      ),
    );
  }

  Widget description() {
    return SizedBox(
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
            : widget.data['description'].toString().triming(32),
        style: TextStyle(
            fontSize: widget.data['description'].length > 50
                ? DeviceInfo().height() / 60
                : DeviceInfo().height() / 50),
      ),
    );
  }

  Widget moreButton() {
    return widget.expanded
        ? empty()
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
                    color: color1, fontSize: DeviceInfo().height() / 50),
              ),
            ),
          );
  }

  Widget numberOfTranslations() {
    return Container(
      height: DeviceInfo().height() / 30,
      decoration: BoxDecoration(
          color: color2,
          borderRadius: BorderRadius.circular(DeviceInfo().height() / 60)),
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: DeviceInfo().height() / 60),
        child: Text(
          "${"Questions".transl()} ${widget.data['translations'] ?? widget.data['data'].length}",
          style: textColor(Colors.white),
        ),
      ),
    );
  }

  Widget infoLanguage() {
    return Container(
      height: DeviceInfo().height() / 30,
      decoration: BoxDecoration(
          color: color5,
          borderRadius: BorderRadius.circular(DeviceInfo().height() / 60)),
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: DeviceInfo().height() / 60),
        child: Text(
          "${widget.data['from']['name'].toString().transl()} $arrow ${widget.data['to']['name'].toString().transl()}",
          style: textColor(Colors.white),
        ),
      ),
    );
  }
}
