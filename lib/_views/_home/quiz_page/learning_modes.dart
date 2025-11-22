import 'package:freequiz/_views/_home/quiz_page/learning_mode.dart';
import 'package:freequiz/utilities/imports/base.dart';

class LearningModes extends StatefulWidget {
  final Axis scrollDirection;
  final String uuid;
  const LearningModes({super.key, this.scrollDirection = Axis.vertical, required this.uuid});

  @override
  State<LearningModes> createState() => _LearningModesState();
}

class _LearningModesState extends State<LearningModes> {
  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double width = context.mobileLayout ? (context.screenWidth - 75) / 4 : (context.screenWidth - 100) / 4;
    double height = context.mobileLayout ? width : 80 ;

    return Container(
      width: context.screenWidth,
      height: height + 20,
      color: context.darkMode ? darkMainColor : lightMainColor,
      padding: const EdgeInsets.only(bottom: 15.0, left: 15.0, right: 15.0, top: 5),
      child: ListView.separated(
        scrollDirection: widget.scrollDirection,
        itemCount: 4,
        itemBuilder: (BuildContext context, int i) {
          return LearningMode(height: height, width: width, i: i, refresh: refresh);
        },
        separatorBuilder: (context, index) => SizedBox(
          width: context.mobileLayout ? 15 : 20,
        ),
      ),
    );
  }
}
