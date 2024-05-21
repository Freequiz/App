import 'package:flutter/material.dart';
import 'package:freequiz/_views/switcher/button.dart';
import 'package:freequiz/others/device_info.dart';
import 'package:freequiz/others/style.dart';

class Switcher extends StatefulWidget {
  const Switcher(
      {super.key,
      required this.onTap,
      required this.texts,
      required this.value,
      required this.width,
      this.icons});

  final Function onTap;
  final List<String> texts;
  final String value;
  final List<Icon>? icons;
  final double width;

  @override
  State<Switcher> createState() => _SwitcherState();
}

class _SwitcherState extends State<Switcher> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: widget.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(DeviceInfo().height() / 100),
        color: DeviceInfo.darkMode ? backgroundGray : backgroundWhite,
      ),
      child: Row(
        children: children(),
      ),
    );
  }

  List<Widget> children() {
    final List<Widget> children = [];
    for (int i = 0; i < widget.texts.length; i++) {
      children.add(
        SwitcherButton(
                onTap: widget.onTap,
                selected: widget.texts[i] == widget.value,
                text: widget.texts[i],
                icon: widget.icons?[i],
                width: widget.width / widget.texts.length),
      );
    }
    return children;
  }
}
