import 'package:flutter/material.dart';
import 'package:freequiz/others/device_info.dart';
import 'package:freequiz/others/string_extensions.dart';
import 'package:freequiz/others/style.dart';
import 'package:freequiz/others/utilities.dart';

class SwitcherButton extends StatelessWidget {
  const SwitcherButton(
      {super.key,
      required this.onTap,
      required this.selected,
      required this.text,
      required this.width,
      this.icon});

  final Function onTap;
  final bool selected;
  final String text;
  final Icon? icon;
  final double width;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => onTap(text),
      child: Container(
        width: width,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(DeviceInfo().height() / 100),
          color: selected
              ? DeviceInfo.darkMode
                  ? highlightGray
                  : highlightWhite
              : const Color.fromARGB(0, 69, 69, 69),
        ),
        child: Center(
          child: icon ??
              Text(
                text.transl(),
                style: textSize(DeviceInfo().height() / 60),
              ),
        ),
      ),
    );
  }
}
