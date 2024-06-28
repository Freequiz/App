import 'package:easy_localization/easy_localization.dart';
import 'package:freequiz/utilities/imports/base.dart';

class KebabMenuItem extends StatelessWidget {
  final Function onTap;
  final IconData icon;
  final String text;
  const KebabMenuItem(
      {super.key, required this.onTap, required this.icon, required this.text});


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              context.tr(text),
              style: fontSize(FontSize.button)
            ),
            Icon(
              icon,
              size: context.screenHeight/ 40,
              color: context.darkMode ? Colors.white : gray40,
            )
          ],
        ),
      ),
    );
  }
}