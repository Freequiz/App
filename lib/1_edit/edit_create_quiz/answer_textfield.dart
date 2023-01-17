import 'package:flutter/material.dart';
import 'package:freequiz/others/initial_loading.dart';
import 'package:freequiz/others/style.dart';
import 'package:freequiz/others/textfield_data.dart';

class AnswerTextField extends StatefulWidget {
  final TextFieldData textFieldData;
  final double widthBorder;
  final Function onSubmitted;
  final int i;
  const AnswerTextField({
    super.key,
    required this.textFieldData,
    this.widthBorder = 2.0,
    required this.onSubmitted, required this.i
  });

  @override
  State<AnswerTextField> createState() => _AnswerTextFieldState();
}

class _AnswerTextFieldState extends State<AnswerTextField> {
  @override
  Widget build(BuildContext context) {
    final brightness = MediaQuery.of(context).platformBrightness;
    bool darkMode = brightness == Brightness.dark;
    final hintColor =
        darkMode ? Colors.white : const Color.fromARGB(255, 40, 40, 40);
    return TextField(
      onSubmitted: (value) {
        widget.onSubmitted(widget.i);
      },
      onChanged: (value) {
        setState(() {
          widget.textFieldData.error = false;
        });
      },
      onEditingComplete: () {},
      controller: widget.textFieldData.input,
      keyboardAppearance: darkMode ? Brightness.dark : Brightness.light,
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
            ? language["Answer can't be blank"]
            : widget.textFieldData.hint,
        border: const OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: widget.textFieldData.error ? Colors.red : color1,
            width: widget.widthBorder,
          ),
        ),
      ),
    );
  }
}
