import 'package:easy_localization/easy_localization.dart';
import 'package:freequiz/utilities/imports/themes.dart';

class Completion extends StatelessWidget {
  final ColorFamily color;
  final Function reset;
  const Completion({super.key, required this.color, required this.reset});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: context.mobileLayout ? 13 : context.screenHeight / 80,
          left: context.mobileLayout ? 13 : context.screenHeight / 80,
          right: context.mobileLayout ? 13 : context.screenHeight / 80,
          bottom: 5),
      margin: const EdgeInsets.only(
        left: 10.0,
        right: 10.0,
        bottom: 15.0,
      ),
      width: context.screenWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(13),
        color: context.darkMode ? gray60 : white235,
      ),
      child: Column(
        children: [
          Text(
            context.tr("completed"),
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          Text(context.tr("restart")),
          TextButton(
            onPressed: () => reset(),
            child: Text(
              context.tr("start over"),
              style: TextStyle(color: color.light),
            ),
          )
        ],
      ),
    );
  }
}
