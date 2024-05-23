import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:freequiz/others/device_info.dart';
import 'package:freequiz/others/style.dart';
import 'package:freequiz/others/utilities.dart';

class KebabMenuItem extends StatelessWidget {
  final Function onTap;
  final IconData icon;
  final String text;
  const KebabMenuItem(
      {super.key, required this.onTap, required this.icon, required this.text});


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              context.tr(text),
              style: textSize(DeviceInfo().height() / 40),
            ),
            Icon(
              icon,
              size: DeviceInfo().height() / 40,
              color: DeviceInfo.darkMode ? Colors.white : textGray,
            )
          ],
        ),
      ),
    );
  }
}