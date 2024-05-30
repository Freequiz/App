import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:freequiz/1_edit/confirmation.dart';
import 'package:freequiz/_views/buttons/edit.dart';
import 'package:freequiz/_views/quiz_tile/additional_info.dart';
import 'package:freequiz/_views/quiz_tile/description.dart';
import 'package:freequiz/_views/quiz_tile/title.dart';
import 'package:freequiz/loading/load_quiz.dart';
import 'package:freequiz/others/device_info.dart';
import 'package:freequiz/others/style.dart';
import 'package:freequiz/utilities/conditional.dart';

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
        ? gray55
        : white235;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => loadQuiz(
        context: context,
        uuid: widget.uuid,
      ),
      child: Conditional(
        condition: shown,
        widget: Dismissible(
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
                  TileTitle(
                    title: widget.data['title'],
                    button: Edit(widget: widget),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Description(
                          expanded: expanded,
                          width: DeviceInfo().width() - 20,
                          description: widget.data['description']),
                      Conditional(
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
                              style: TextStyle(
                                  color: grayFreequiz,
                                  fontSize: DeviceInfo().height() / 50),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Conditional(condition: expanded, widget: AdditionalInfo(data: widget.data))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
