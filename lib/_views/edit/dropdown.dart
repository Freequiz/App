import 'package:flutter/material.dart';
import 'package:freequiz/others/style.dart';
import 'package:freequiz/utilities/extensions/context_extensions.dart';

class Dropdown extends StatefulWidget {

  final dynamic initialValue;
  final List<DropdownMenuItem<dynamic>> items;
  final Function onChanged;
  final Color hintColor;

  const Dropdown({super.key, required this.initialValue, required this.items, required this.onChanged, required this.hintColor});

  @override
  State<Dropdown> createState() => _DropdownState();
}

class _DropdownState extends State<Dropdown> {
  dynamic value;

  @override
  void initState() {
    value = widget.initialValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: value,
      icon: const Icon(
        Icons.arrow_drop_down_rounded,
        color: grayFreequiz,
      ),
      underline: Container(
        height: 2,
        color: grayFreequiz,
      ),
      dropdownColor:
          context.darkMode ? gray40 : const Color.fromARGB(255, 229, 242, 250),
      items: widget.items,
      onChanged: (newValue) {
        setState(() {
          value = newValue!;
          widget.onChanged(value!);
        });
      },
      style: TextStyle(color: widget.hintColor),
    );
  }
}
