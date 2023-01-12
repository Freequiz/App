import 'package:flutter/material.dart';
import 'package:freequiz/others/textfield_data.dart';

class BasicTextField extends StatefulWidget {
  final TextFieldData textFieldData;
  final Color colorBorder;
  final double widthBorder;
  final String hintError;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final int maxLines;
  const BasicTextField({
    super.key,
    required this.textFieldData,
    required this.hintError,
    required this.colorBorder,
    this.widthBorder = 2.0,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.maxLines = 1,
  });

  @override
  State<BasicTextField> createState() => _BasicTextFieldState();
}

class _BasicTextFieldState extends State<BasicTextField> {
  @override
  Widget build(BuildContext context) {
    final brightness = MediaQuery.of(context).platformBrightness;
    bool darkMode = brightness == Brightness.dark;
    final hintColor =
        darkMode ? Colors.white : const Color.fromARGB(255, 40, 40, 40);
    return TextField(
      onSubmitted: (value) {
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
      maxLines: widget.maxLines,
      decoration: InputDecoration(
        filled: true,
        fillColor: darkMode
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
