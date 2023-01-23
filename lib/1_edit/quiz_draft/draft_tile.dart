import 'package:flutter/material.dart';
import 'package:freequiz/1_edit/quiz_draft/edit_draft.dart';
import 'package:freequiz/others/initial_loading.dart';
import 'package:freequiz/quiz.dart';
import 'package:freequiz/others/device_info.dart';

class DraftTile extends StatefulWidget {
  final Function refresh;
  const DraftTile({super.key, required this.refresh});

  @override
  State<DraftTile> createState() => _DraftTileState();
}

class _DraftTileState extends State<DraftTile> {
  bool shown = true;

  refresh() {
    setState(() {});
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
              key: const Key('Draft'),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) async {
                await Quiz().deleteDraft();
                setState(() {
                  Quiz.draft.clear();
                  shown = false;
                });
                widget.refresh();
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
                    ? DeviceInfo().height() / 30 * 2.5 + 15
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
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              Quiz.draft['title'] != ""
                                  ? Quiz.draft['title']
                                  : language["Emtpy title"],
                              style: TextStyle(
                                  fontSize: DeviceInfo().height() / 30,
                                  color: Colors.red),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: DeviceInfo().height() / 30,
                            child: Text(
                              trim(Quiz.draft['description']),
                              style: TextStyle(
                                  fontSize:
                                      Quiz.draft['description'].length > 50
                                          ? DeviceInfo().height() / 60
                                          : DeviceInfo().height() / 50,
                                  color: Colors.red),
                            ),
                          ),
                        ],
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
    if (trimmedDescription.length == Quiz.draft['description'].length) {
      return trimmedDescription;
    }
    return '$trimmedDescription...';
  }

  onTap() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return EditDraft(
            refresh: refresh,
          );
        },
      ),
    );
  }
}
