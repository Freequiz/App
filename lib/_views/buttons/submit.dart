import 'package:freequiz/utilities/imports/utilities.dart';

class SubmitButton extends StatelessWidget {

  final bool pressed;
  final Function onPressed;

  const SubmitButton({super.key, required this.pressed, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: grayFreequiz,
        foregroundColor: Colors.white,
      ),
      onPressed: () {
        pressed ? () {} : onPressed();
      },
      child: Conditional(
        condition: pressed,
        widget: SizedBox(
          width: context.mobileLayout ? context.screenHeight/ 30 : 30,
          height: context.mobileLayout ? context.screenHeight/ 30 : 30,
          child: const CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
        defaultWidget: const Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}
