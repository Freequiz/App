import 'package:easy_localization/easy_localization.dart';
import 'package:freequiz/utilities/imports/utilities.dart';

class LoadMoreButton extends StatelessWidget {
  final Function onPressed;
  final bool pressed;

  const LoadMoreButton({super.key, required this.pressed, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Conditional(
        condition: pressed,
        widget: CircularProgressIndicator(
          color: context.darkMode ? Colors.white : grayFreequiz,
        ),
        defaultWidget: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: grayFreequiz,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.all(10.0),
          ),
          onPressed: () => onPressed(),
          child: Text(
            context.tr('load more'),
            style: const TextStyle(
              color: Colors.white,
              fontSize: FontSize.button,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
