import 'package:flutter/material.dart';
import 'package:freequiz/others/device_info.dart';

class InfoBadge extends StatelessWidget {
  const InfoBadge({super.key, required this.color, required this.text});

  final String text;
  final Color color;
  final arrow = '\u279C';

  @override
  Widget build(BuildContext context) {
    return Container(
      height: DeviceInfo().height() / 30,
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(DeviceInfo().height() / 60)),
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: DeviceInfo().height() / 60),
        child: Text(
          text,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
