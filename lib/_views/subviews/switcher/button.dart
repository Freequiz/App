import 'package:easy_localization/easy_localization.dart';
import 'package:freequiz/utilities/imports/base.dart';

class SwitcherButton extends StatelessWidget {
  const SwitcherButton({super.key, required this.onTap, required this.text, this.icon, required this.selected});

  final Function onTap;
  final bool selected;
  final String text;
  final Icon? icon;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => onTap(text),
        child: Center(
          child: icon ??
              Text(
                context.tr(text),
                style: TextStyle(
                  fontSize: FontSize.item,
                  fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
        ),
      ),
    );
  }
}
