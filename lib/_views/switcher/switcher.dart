import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:freequiz/_views/switcher/button.dart';
import 'package:freequiz/others/device_info.dart';
import 'package:freequiz/others/style.dart';

class Switcher extends StatefulWidget {
  const Switcher(
      {super.key, required this.onTap, required this.texts, required this.value, required this.width, this.icons});

  final Function onTap;
  final List<String> texts;
  final String value;
  final List<Icon>? icons;
  final double width;

  @override
  State<Switcher> createState() => _SwitcherState();
}

class _SwitcherState extends State<Switcher> {
  String previousValue = "";
  bool onChange = false;

  @override
  void initState() {
    previousValue = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: widget.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(DeviceInfo().height() / 100),
        color: DeviceInfo.darkMode ? backgroundGray : backgroundWhite,
      ),
      child: Stack(
        children: [
          Container(
            width: widget.width / widget.texts.length,
            height: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(DeviceInfo().height() / 100),
                color: DeviceInfo.darkMode ? highlightGray : highlightWhite),
          )
              .animate(target: onChange ? 1 : 0)
              .moveX(
                begin: widget.texts.indexOf(previousValue) * widget.width / widget.texts.length,
                end: widget.texts.indexOf(widget.value) * widget.width / widget.texts.length,
                duration: const Duration(milliseconds: 300),
              )
              .callback(
                callback: (_) => setState(() {
                  previousValue = widget.value;
                  onChange = false;
                }),
              ),
          Row(
            children: children(),
          ),
        ],
      ),
    );
  }

  List<Widget> children() {
    final List<Widget> children = [];
    for (int i = 0; i < widget.texts.length; i++) {
      children.add(
        SwitcherButton(
            onTap: onTap,
            selected: widget.texts[i] == widget.value,
            text: widget.texts[i],
            icon: widget.icons?[i],
            width: widget.width / widget.texts.length),
      );
    }
    return children;
  }

  onTap(String text) {
    setState(() {
      onChange = true;
    });
    widget.onTap(text);
  }
}
