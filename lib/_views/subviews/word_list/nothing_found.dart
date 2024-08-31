import 'package:easy_localization/easy_localization.dart';
import 'package:freequiz/utilities/imports/base.dart';

class NothingFound extends StatelessWidget {
  const NothingFound({super.key});

  @override
  Widget build(BuildContext context) {
    final color5 = context.darkMode
        ? gray60
        : white225;
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    final bool mobileLayout = shortestSide < 600;
    return Container(
      width: context.screenWidth - 20,
      height: context.screenHeight / 18,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(13),
          bottomRight: Radius.circular(13),
        ),
        color: color5,
      ),
      child: Padding(
        padding: EdgeInsets.all(mobileLayout ? 0 : context.screenHeight / 80),
        child: Center(
          child: Text(
            context.tr('nothing found'),
            style: fontSize(FontSize.text),
          ),
        ),
      ),
    );
  }
}
