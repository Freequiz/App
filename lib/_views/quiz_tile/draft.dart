import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:freequiz/1_edit/quiz_draft/edit_draft.dart';
import 'package:freequiz/_views/quiz_tile/title.dart';
import 'package:freequiz/local_storage/draft_storage.dart';
import 'package:freequiz/utilities/extensions/context_extensions.dart';
import 'package:freequiz/utilities/extensions/string_extensions.dart';
import 'package:freequiz/others/style.dart';
import 'package:freequiz/quiz/quiz_helper.dart';
import 'package:freequiz/utilities/widgets/conditional.dart';


class DraftTile extends StatefulWidget {
  final Function refresh;
  const DraftTile({super.key, required this.refresh});

  @override
  State<DraftTile> createState() => _DraftTileState();
}

class _DraftTileState extends State<DraftTile> {
  bool shown = true;

  @override
  Widget build(BuildContext context) {
    final color6 = context.darkMode
        ? gray55
        : white235;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        onTap();
      },
      child: Conditional(
        condition: shown,
        widget: Dismissible(
          key: const Key('Draft'),
          direction: DismissDirection.endToStart,
          onDismissed: (direction) async {
            await DraftStorage.deleteDraft();
            setState(() {
              QuizHelper.draft.clear();
              shown = false;
            });
            widget.refresh();
          },
          background: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(context.screenHeight/ 100),
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
            height: context.mobileLayout
                ? context.screenHeight/ 30 * 2.5 + 15
                : context.screenHeight/ 30 * 2.5 + 35,
            width: context.screenWidth - 20,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(context.screenHeight/ 100),
              color: color6,
            ),
            child: Padding(
              padding: context.mobileLayout
                  ? const EdgeInsets.only(
                      left: 10.0, right: 10.0, bottom: 10.0, top: 5.0)
                  : const EdgeInsets.only(
                      left: 20.0, right: 20.0, bottom: 20.0, top: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TileTitle(
                    title: QuizHelper.draft['title'] != ""
                        ? QuizHelper.draft['title']
                        : context.tr('empty title'),
                    color: Colors.red,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: context.screenHeight/ 30,
                        child: Text(
                          QuizHelper.draft['description']
                              .toString()
                              .truncate(32),
                          style: TextStyle(
                            fontSize:
                                QuizHelper.draft['description'].length > 50
                                    ? context.screenHeight/ 60
                                    : context.screenHeight/ 50,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  onTap() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return EditDraft(
            refresh: widget.refresh,
          );
        },
      ),
    );
  }
}
