import 'package:flutter/material.dart';
import 'package:freequiz/_views/subviews/textfields/basic_textfield.dart';
import 'package:freequiz/models/textfield_data.dart';

class EmailTextfield extends StatefulWidget {
  final TextFieldData email;
  final FocusNode focusNode;
  final Function? onSubmitted;

  const EmailTextfield({super.key, required this.email, required this.focusNode, this.onSubmitted});

  @override
  State<EmailTextfield> createState() => _EmailTextfieldState();
}

class _EmailTextfieldState extends State<EmailTextfield> {
  @override
  Widget build(BuildContext context) {
    return BasicTextfield(
      data: widget.email,
      onSubmitted: () {
        if (widget.onSubmitted == null) {
          widget.focusNode.requestFocus();
          setState(() {
            widget.email.error = false;
          });
        }
        else {
          widget.onSubmitted!();
        }
      },
      textInputAction: TextInputAction.next,
      textInputType: TextInputType.emailAddress,
      autofillHints: const [AutofillHints.email],
    );
  }
}
