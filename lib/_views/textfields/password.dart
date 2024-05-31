import 'package:flutter/material.dart';
import 'package:freequiz/_views/textfields/basic_textfield.dart';
import 'package:freequiz/models/textfield_data.dart';
import 'package:freequiz/others/style.dart';

class PasswordTextfield extends StatefulWidget {
  final TextFieldData password;
  final Function onPressed;
  final TextInputAction? textInputAction;

  const PasswordTextfield({super.key, required this.password, required this.onPressed, this.textInputAction});

  @override
  State<PasswordTextfield> createState() => _PasswordTextfieldState();
}

class _PasswordTextfieldState extends State<PasswordTextfield> {
  @override
  Widget build(BuildContext context) {
    return BasicTextfield(
      data: widget.password,
      onSubmitted: widget.onPressed,
      obscureText: !widget.password.shown,
      textInputAction: widget.textInputAction,
      suffixIcon: IconButton(
          icon: Icon(
            widget.password.shown ? Icons.visibility : Icons.visibility_off,
            color: grayFreequiz,
          ),
          onPressed: () {
            setState(() {
              widget.password.shown = !widget.password.shown;
            });
          },
        ),
    );
  }
}
