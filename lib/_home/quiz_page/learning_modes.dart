import 'package:flutter/material.dart';
import 'package:freequiz/loading/load_progress.dart';
import 'package:freequiz/quiz.dart';

class LearningModes extends StatefulWidget {
  final Axis scrollDirection;
  final double width;
  final String uuid;
  const LearningModes(
      {super.key, this.scrollDirection = Axis.vertical, required this.width, required this.uuid});

  @override
  State<LearningModes> createState() => _LearningModesState();
}

class _LearningModesState extends State<LearningModes> {
  final List<IconData> icon = const [
    Icons.star_border_rounded,
    Icons.keyboard_alt_outlined,
    Icons.format_list_bulleted_rounded, 
    Icons.quiz_outlined
  ];

  refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    final bool mobileLayout = shortestSide < 600;
    return ListView.separated(
      scrollDirection: widget.scrollDirection,
      itemCount: 4,
      itemBuilder: (BuildContext context, int i) {
        return SizedBox(
          width: widget.width,
          height: widget.width,
          child: TextButton(
            style: TextButton.styleFrom(
              backgroundColor: color[i],
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(widget.width / 7)),
            ),
            onPressed: () => loadProgress(context, widget.uuid, i, reset, refresh),
            child: Icon(
              icon[i],
              size: widget.width / 2,
            ),
          ),
        );
      },
      separatorBuilder: (context, index) => SizedBox(
        width: mobileLayout ? 10 : 20,
        height: mobileLayout ? 10 : 20,
      ),
    );
  }

  reset(i) {
    setState(() {
      Quiz().deleteData(modes[i], widget.uuid);
      Quiz.progressArray = [[], [], [], [], [], [], [], [], [], [], [], [], [], [], [], []];
      for (var i = 0; i < Quiz.definition.length; i++) {
        Quiz.progressArray[0].add(i);
      }
    });
  }
}
