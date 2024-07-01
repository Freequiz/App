import 'package:easy_localization/easy_localization.dart';
import 'package:freequiz/_views/buttons/share.dart';
import 'package:freequiz/_views/quiz_tile/additional_info.dart';
import 'package:freequiz/_views/quiz_tile/title.dart';
import 'package:freequiz/loading/load_quiz.dart';
import 'package:freequiz/_views/quiz_tile/description.dart';
import 'package:freequiz/utilities/imports/utilities.dart';

class QuizTile extends StatefulWidget {
  final Map data;
  final bool expanded;
  final String uuid;
  final Widget? button;
  final double width;
  final double? height;
  const QuizTile(
      {super.key,
      required this.data,
      required this.uuid,
      this.expanded = true,
      this.button,
      required this.width,
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
        child: Padding(
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
                      color: context.darkMode ? Colors.white : gray40,
                    ),
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
        height: context.screenHeight / 30,
        child: GestureDetector(
          onTap: () {
            setState(() {
              expanded = true;
            });
          },
          child: Text(
            expanded ? "" : context.tr('more'),
            style: const TextStyle(
              color: grayFreequiz,
              fontSize: FontSize.button,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
