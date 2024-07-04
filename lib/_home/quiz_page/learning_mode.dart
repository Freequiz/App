import 'package:easy_localization/easy_localization.dart';
import 'package:freequiz/loading/load_learning.dart';
import 'package:freequiz/quiz/learning.dart';
import 'package:freequiz/utilities/imports/utilities.dart';
import 'package:material_symbols_icons/symbols.dart';

class LearningMode extends StatelessWidget {
  final double width;
  final double height;
  final int i;
  final Function refresh;

  const LearningMode({super.key, required this.height, required this.width, required this.i, required this.refresh});

  final List<IconData> icons = const [
    Symbols.magic_button,
    Symbols.keyboard,
    Symbols.format_list_bulleted,
    Symbols.rectangle_rounded
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: colors[i].light,
          foregroundColor: colors[i].dark,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(height / 4)),
        ),
        onPressed: () => loadLearning(context, i, refresh),
        child: LayoutWidget(
          mobile: icon(),
          tablet: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: icon(),
              ),
              SizedBox(
                width: width - height / 2 - 44,
                child: Text(
                  context.tr(Learning.modes[i]),
                  style: context.screenWidth > 900 ? titleStyle() : fontSize(FontSize.secondary),
                  maxLines: 2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Icon icon() {
    return Icon(
      icons[i],
      size: height / 2,
      weight: 600,
      grade: 200,
      color: colors[i].dark,
    );
  }
}
