import 'package:flutter/material.dart';
import 'package:freequiz/_views/subviews/textfields/basic_textfield.dart';
import 'package:freequiz/models/textfield_data.dart';

class UsernameTextfield extends StatefulWidget {
  final TextFieldData username;
  final FocusNode focusNode;
  final Function? onSubmitted;
  final Iterable<String>? autofillHints;

  const UsernameTextfield({super.key, required this.username, required this.focusNode, this.onSubmitted, required this.autofillHints});

  @override
  State<UsernameTextfield> createState() => _UsernameTextfieldState();
}

class _UsernameTextfieldState extends State<UsernameTextfield> {
  @override
  Widget build(BuildContext context) {
    return BasicTextfield(
      data: widget.username,
      onSubmitted: () {
        if (widget.onSubmitted == null) {
          widget.focusNode.requestFocus();
        setState(() {
          widget.username.error = false;
        });
        }
        else {
          widget.onSubmitted!();
        }
      },
      textInputAction: TextInputAction.next,
      textInputType: TextInputType.emailAddress,
      autofillHints: widget.autofillHints,
    );
  }
}
