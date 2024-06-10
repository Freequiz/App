import 'package:flutter/material.dart';
import 'package:freequiz/others/style.dart';
import 'package:freequiz/utilities/extensions/context_extensions.dart';
import 'package:freequiz/utilities/widgets/conditional.dart';

class SubmitButton extends StatelessWidget {

  final bool pressed;
  final Function onPressed;

  const SubmitButton({super.key, required this.pressed, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.mobileLayout ? context.screenHeight/ 20 : 40,
      child: TextButton(
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
      ),
    );
  }
}
