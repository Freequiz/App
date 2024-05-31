import 'package:flutter/material.dart';
import 'package:freequiz/_views/textfields/basic_textfield.dart';
import 'package:freequiz/models/textfield_data.dart';
import 'package:freequiz/others/style.dart';

class PasswordConfirmationTextfield extends StatefulWidget {
  final TextFieldData passwordConfirmation;
  final Function onSubmitted;

  const PasswordConfirmationTextfield({super.key, required this.passwordConfirmation, required this.onSubmitted});

  @override
  State<PasswordConfirmationTextfield> createState() => _PasswordConfirmationTextfieldState();
}

class _PasswordConfirmationTextfieldState extends State<PasswordConfirmationTextfield> {
  @override
  Widget build(BuildContext context) {
    return BasicTextfield(
      data: widget.passwordConfirmation,
      onSubmitted: widget.onSubmitted,
      obscureText: !widget.passwordConfirmation.shown,
      suffixIcon: IconButton(
          icon: Icon(
            widget.passwordConfirmation.shown ? Icons.visibility : Icons.visibility_off,
            color: grayFreequiz,
          ),
          onPressed: () {
            setState(() {
              widget.passwordConfirmation.shown = !widget.passwordConfirmation.shown;
            });
          },
        ),
    );
  }
}
