import 'package:easy_localization/easy_localization.dart';
import 'package:freequiz/utilities/imports/utilities.dart';

class LoadMoreButton extends StatelessWidget {
  final Function onPressed;
  final bool pressed;
  final bool more;

  const LoadMoreButton({super.key, required this.pressed, required this.onPressed, required this.more});

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Conditional(
        condition: more,
        widget: Conditional(
          condition: pressed,
          widget: CircularProgressIndicator(
            color: context.darkMode ? Colors.white : grayFreequiz,
          ),
          defaultWidget: TextButton(
            style: TextButton.styleFrom(
              backgroundColor: context.darkMode ? gray60 : white235,
              foregroundColor: context.darkMode ? Colors.white : gray40,
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
            ),
            onPressed: () => onPressed(),
            child: Text(
              context.tr('more'),
              style: const TextStyle(
                fontSize: FontSize.button,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
        defaultWidget: const SizedBox(),
      ),
    );
  }
}
