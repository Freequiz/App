import 'package:flutter/material.dart';
import 'package:freequiz/others/device_info.dart';
import 'package:freequiz/others/style.dart';
import 'package:freequiz/models/textfield_data.dart';

class BasicTextField extends StatefulWidget {
  final TextFieldData textFieldData;
  final Color colorBorder;
  final double widthBorder;
  final String hintError;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final int maxLines;
  final Function save;
  const BasicTextField({
    super.key,
    required this.textFieldData,
    required this.hintError,
    this.colorBorder = grayFreequiz,
    this.widthBorder = 2.0,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.maxLines = 1, required this.save
  });

  @override
  State<BasicTextField> createState() => _BasicTextFieldState();
}

class _BasicTextFieldState extends State<BasicTextField> {
  @override
  Widget build(BuildContext context) {
    final hintColor =
        DeviceInfo.darkMode ? Colors.white : gray40;
    return TextField(
      onSubmitted: (value) {
        widget.save();
        FocusScope.of(context).nextFocus();
      },
      onChanged: (value) {
        setState(() {
          widget.textFieldData.error = false;
        });
      },
      textInputAction: widget.textInputAction,
      onEditingComplete: () {},
      controller: widget.textFieldData.input,
      keyboardType: widget.keyboardType,
      keyboardAppearance: DeviceInfo.darkMode ? Brightness.dark : Brightness.light,
      maxLines: widget.maxLines,
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
            ? widget.hintError
            : widget.textFieldData.hint,
        border: const OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: widget.textFieldData.error ? Colors.red : widget.colorBorder,
            width: widget.widthBorder,
          ),
        ),
      ),
    );
  }
}
