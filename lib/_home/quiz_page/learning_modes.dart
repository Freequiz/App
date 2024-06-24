import 'package:freequiz/loading/load_learning.dart';
import 'package:freequiz/quiz/learning.dart';
import 'package:freequiz/quiz/progress.dart';
import 'package:freequiz/utilities/imports/base.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class LearningModes extends StatefulWidget {
  final Axis scrollDirection;
  final String uuid;
  const LearningModes({super.key, this.scrollDirection = Axis.vertical, required this.uuid});

  @override
  State<LearningModes> createState() => _LearningModesState();
}

class _LearningModesState extends State<LearningModes> {
  final List<IconData> icon = const [
    Symbols.magic_button,
    Symbols.keyboard,
    Symbols.format_list_bulleted,
    Symbols.rectangle_rounded
  ];

  refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double width = context.mobileLayout ? (context.screenWidth - 75) / 4 : (context.screenWidth - 100) / 4;

    return Container(
      width: context.screenWidth,
      height: width + 20,
      color: context.darkMode ? darkMainColor : lightMainColor,
      padding: const EdgeInsets.only(bottom: 15.0, left: 15.0, right: 15.0, top: 5),
      child: ListView.separated(
        scrollDirection: widget.scrollDirection,
        itemCount: 4,
        itemBuilder: (BuildContext context, int i) {
          return SizedBox(
            width: width,
            height: width,
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: colors[i].light,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(width / 4)),
              ),
              onPressed: () => loadLearning(context, widget.uuid, i, reset, refresh),
              child: Icon(
                icon[i],
                size: width / 2,
                weight: 600,
                grade: 200,
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => SizedBox(
          width: context.mobileLayout ? 15 : 20,
        ),
      ),
    );
  }

  reset(i) {
    setState(() {
      Progress.reset(Learning.modes[i], widget.uuid);
    });
  }
}
