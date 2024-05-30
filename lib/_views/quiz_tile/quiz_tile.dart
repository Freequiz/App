import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:freequiz/_views/buttons/share.dart';
import 'package:freequiz/_views/quiz_tile/additional_info.dart';
import 'package:freequiz/_views/quiz_tile/title.dart';
import 'package:freequiz/loading/load_quiz.dart';
import 'package:freequiz/others/device_info.dart';
import 'package:freequiz/others/style.dart';
import 'package:freequiz/_views/quiz_tile/description.dart';
import 'package:freequiz/utilities/conditional.dart';

class QuizTile extends StatefulWidget {
  final Map data;
  final bool expanded;
  final String uuid;
  final double width;
  const QuizTile({super.key, required this.data, required this.uuid, this.expanded = true, required this.width});

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
    final color6 =
        DeviceInfo.darkMode ? gray55 : white235;
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
              ? const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0, top: 3.0)
              : const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0, top: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TileTitle(
                title: widget.data['title'],
                button: ShareButton(
                    url: "https://www.freequiz.ch/quiz/${widget.uuid}",
                    color: DeviceInfo.darkMode ? Colors.white : gray40),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Description(expanded: expanded, width: widget.width, description: widget.data['description']),
                  moreButton()
                ],
              ),
              Conditional(condition: expanded, widget: AdditionalInfo(data: widget.data)),
            ],
          ),
        ),
      ),
    );
  }

  Widget moreButton() {
    return Conditional(
      condition: !widget.expanded,
      widget: SizedBox(
        height: DeviceInfo().height() / 30,
        child: GestureDetector(
          onTap: () {
            setState(() {
              expanded = true;
            });
          },
          child: Text(
            expanded ? "" : context.tr('more'),
            style: TextStyle(color: grayFreequiz, fontSize: DeviceInfo().height() / 50),
          ),
        ),
      ),
    );
  }
}
