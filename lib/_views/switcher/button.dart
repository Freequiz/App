import 'package:easy_localization/easy_localization.dart';
import 'package:freequiz/others/utilities.dart';
import 'package:freequiz/utilities/imports/base.dart';

class SwitcherButton extends StatelessWidget {
  const SwitcherButton({super.key, required this.onTap, required this.text, required this.width, this.icon});

  final Function onTap;
  final String text;
  final Icon? icon;
  final double width;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => onTap(text),
      child: SizedBox(
        width: width,
        height: 50,
        child: Center(
          child: icon ??
              Text(
                context.tr(text),
                style: textSize(context.screenHeight / 60),
              ),
        ),
      ),
    );
  }
}
