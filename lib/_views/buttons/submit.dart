import 'package:flutter/material.dart';
import 'package:freequiz/others/device_info.dart';
import 'package:freequiz/others/style.dart';
import 'package:freequiz/utilities/conditional.dart';

class SubmitButton extends StatelessWidget {

  final bool pressed;
  final Function onPressed;

  const SubmitButton({super.key, required this.pressed, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: DeviceInfo.mobileLayout ? DeviceInfo().height() / 20 : 40,
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
            width: DeviceInfo.mobileLayout ? DeviceInfo().height() / 30 : 30,
            height: DeviceInfo.mobileLayout ? DeviceInfo().height() / 30 : 30,
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
