import 'package:freequiz/_views/subviews/buttons/dismiss.dart';
import 'package:freequiz/_views/subviews/buttons/expand.dart';
import 'package:freequiz/_views/subviews/buttons/share.dart';
import 'package:freequiz/_views/subviews/quiz_tile/additional_info.dart';
import 'package:freequiz/_views/subviews/quiz_tile/title.dart';
import 'package:freequiz/loading/load_quiz.dart';
import 'package:freequiz/_views/subviews/quiz_tile/description.dart';
import 'package:freequiz/utilities/imports/utilities.dart';

class QuizTile extends StatefulWidget {
  final Map data;
  final bool expanded;
  final String uuid;
  final Widget? button;
  final double width;
  final double? height;
  final Function? onDismissed;
  const QuizTile(
      {super.key,
      required this.data,
      required this.uuid,
      this.expanded = true,
      this.button,
      required this.width,
      this.onDismissed,
      this.height});

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
    final color6 = context.darkMode ? gray55 : white235;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => loadQuiz(
        context: context,
        uuid: widget.uuid,
      ),
      child: Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(context.screenHeight / 100),
          color: color6,
        ),
        padding: context.mobileLayout
            ? const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0, top: 3.0)
            : const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15.0, top: 5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TileTitle(
              title: widget.data['title'],
              button: widget.button ??
                  ShareButton(
                    url: "https://www.freequiz.ch/quiz/${widget.uuid}",
                  ),
              dismissButton: DismissButton(
                onDismissed: widget.onDismissed != null ? () => widget.onDismissed!(widget.data['id']) : () {},
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Description(expanded: expanded, width: widget.width, description: widget.data['description']),
                ExpandButton(
                  shown: !widget.expanded,
                  onPressed: () {
                    setState(() {
                      expanded = !expanded;
                    });
                  },
                ),
              ],
            ),
            Conditional(condition: expanded, widget: AdditionalInfo(data: widget.data)),
          ],
        ),
      ),
    );
  }
}
