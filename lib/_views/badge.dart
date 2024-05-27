import 'package:flutter/material.dart';
import 'package:freequiz/others/device_info.dart';

class InfoBadge extends StatelessWidget {
  const InfoBadge({super.key, required this.color, required this.text});

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(100)),
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
