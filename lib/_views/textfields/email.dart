import 'package:flutter/material.dart';
import 'package:freequiz/_views/textfields/basic_textfield.dart';
import 'package:freequiz/models/textfield_data.dart';

class EmailTextfield extends StatefulWidget {
  final TextFieldData email;
  final FocusNode focusNode;

  const EmailTextfield({super.key, required this.email, required this.focusNode});

  @override
  State<EmailTextfield> createState() => _EmailTextfieldState();
}

class _EmailTextfieldState extends State<EmailTextfield> {
  @override
  Widget build(BuildContext context) {
    return BasicTextfield(
      data: widget.email,
      onSubmitted: () {
        widget.focusNode.requestFocus();
        setState(() {
          widget.email.error = false;
        });
      },
      textInputAction: TextInputAction.next,
      textInputType: TextInputType.emailAddress,
    );
  }
}
