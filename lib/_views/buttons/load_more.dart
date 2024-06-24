import 'package:easy_localization/easy_localization.dart';
import 'package:freequiz/utilities/imports/utilities.dart';

class LoadMoreButton extends StatelessWidget {
  final Function onPressed;
  final bool pressed;

  const LoadMoreButton({super.key, required this.pressed, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Conditional(
      condition: pressed,
      widget: Align(
        child: CircularProgressIndicator(
          color: context.darkMode ? Colors.white : grayFreequiz,
        ),
      ),
      defaultWidget: Align(
        child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: grayFreequiz,
            foregroundColor: Colors.white,
          ),
          onPressed: () => onPressed(),
          child: Text(
            context.tr('load more'),
            style: TextStyle(color: Colors.white, fontSize: context.screenHeight / 55),
          ),
        ),
      ),
    );
  }
}
