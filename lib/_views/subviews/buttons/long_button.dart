import 'package:easy_localization/easy_localization.dart';
import 'package:freequiz/utilities/imports/base.dart';
import 'package:material_symbols_icons/symbols.dart';

class LongButton extends StatelessWidget {
  final Function onPressed;
  final String text;
  final Color? color;
  const LongButton({super.key, required this.onPressed, required this.text, this.color});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: color ?? grayFreequiz,
          foregroundColor: context.darkMode ? Colors.white : gray40,
        ),
        onPressed: () => onPressed(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              context.tr(text),
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
            const Icon(
              Symbols.arrow_forward_rounded,
              weight: 700,
              grade: 200,
            )
          ],
        ),
      ),
    );
  }
}
