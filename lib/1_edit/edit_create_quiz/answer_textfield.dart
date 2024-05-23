import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:freequiz/others/device_info.dart';
import 'package:freequiz/others/style.dart';
import 'package:freequiz/others/textfield_data.dart';

class AnswerTextField extends StatefulWidget {
  final TextFieldData textFieldData;
  final double widthBorder;
  final Function onSubmitted;
  final int i;
  final Function save;
  const AnswerTextField(
      {super.key,
      required this.textFieldData,
      this.widthBorder = 2.0,
      required this.onSubmitted,
      required this.i,
      required this.save});

  @override
  State<AnswerTextField> createState() => _AnswerTextFieldState();
}

class _AnswerTextFieldState extends State<AnswerTextField> {
  @override
  Widget build(BuildContext context) {
    final hintColor = DeviceInfo.darkMode
        ? Colors.white
        : const Color.fromARGB(255, 40, 40, 40);
    return TextField(
      onSubmitted: (value) {
        widget.save();
        widget.onSubmitted(widget.i);
      },
      onChanged: (value) {
        setState(() {
          widget.textFieldData.error = false;
        });
      },
      onEditingComplete: () {},
      controller: widget.textFieldData.input,
      keyboardAppearance:
          DeviceInfo.darkMode ? Brightness.dark : Brightness.light,
      decoration: InputDecoration(
        filled: true,
        fillColor: DeviceInfo.darkMode
            ? const Color.fromARGB(255, 45, 45, 45)
            : const Color.fromARGB(255, 234, 247, 255),
        contentPadding: const EdgeInsets.all(10.0),
        hintStyle: TextStyle(
          color: widget.textFieldData.error ? Colors.red : hintColor,
          fontWeight: FontWeight.w500,
        ),
        hintText: widget.textFieldData.error
            ? context.tr('answer blank')
            : widget.textFieldData.hint,
        border: const OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: widget.textFieldData.error ? Colors.red : grayFreequiz,
            width: widget.widthBorder,
          ),
        ),
      ),
    );
  }
}
