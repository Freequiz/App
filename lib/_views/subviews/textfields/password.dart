import 'package:freequiz/_views/subviews/textfields/basic_textfield.dart';
import 'package:freequiz/models/textfield_data.dart';
import 'package:freequiz/utilities/imports/base.dart';

class PasswordTextfield extends StatefulWidget {
  final TextFieldData password;
  final Function? onSubmitted;
  final FocusNode focusNode;
  final TextInputAction? textInputAction;
  final Iterable<String> autofillHints;

  const PasswordTextfield({
    super.key,
    required this.password,
    this.onSubmitted,
    required this.focusNode,
    this.textInputAction,
    required this.autofillHints,
  });

  @override
  State<PasswordTextfield> createState() => _PasswordTextfieldState();
}

class _PasswordTextfieldState extends State<PasswordTextfield> {
  @override
  Widget build(BuildContext context) {
    return BasicTextfield(
      data: widget.password,
      onSubmitted: () {
        if (widget.onSubmitted == null) {
          widget.focusNode.requestFocus();
        } else {
          widget.onSubmitted!();
        }
      },
      obscureText: !widget.password.shown,
      textInputAction: widget.textInputAction,
      autofillHints: widget.autofillHints,
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
