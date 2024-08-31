import 'package:easy_localization/easy_localization.dart';
import 'package:freequiz/models/textfield_data.dart';
import 'package:freequiz/utilities/imports/base.dart';

class AnswerTextField extends StatefulWidget {
  final TextFieldData textFieldData;
  final double widthBorder;
  final Function onSubmitted;
  final Function save;
  const AnswerTextField(
      {super.key, required this.textFieldData, this.widthBorder = 2.0, required this.onSubmitted, required this.save});

  @override
  State<AnswerTextField> createState() => _AnswerTextFieldState();
}

class _AnswerTextFieldState extends State<AnswerTextField> {
  @override
  Widget build(BuildContext context) {
    final hintColor = context.darkMode ? Colors.white : gray40;
    final textfieldColor = context.darkMode ? const Color.fromARGB(255, 65, 65, 65) : white225;
    return TextField(
      onSubmitted: (value) {
        widget.save();
        widget.onSubmitted();
      },
      onChanged: (value) {
        setState(() {
          widget.textFieldData.error = false;
        });
      },
      onEditingComplete: () {},
      controller: widget.textFieldData.input,
      keyboardAppearance: context.darkMode ? Brightness.dark : Brightness.light,
      decoration: InputDecoration(
        filled: true,
        fillColor: textfieldColor,
        contentPadding: const EdgeInsets.all(15.0),
        hintStyle: TextStyle(
          color: widget.textFieldData.error ? Colors.red : hintColor,
          fontWeight: FontWeight.w500,
          fontSize: FontSize.text,
        ),
        hintText: widget.textFieldData.error ? context.tr('answer blank') : widget.textFieldData.hint,
        border: const OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: widget.textFieldData.error ? Colors.red : textfieldColor,
            width: widget.widthBorder,
          ),
          borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(20.0), bottomRight: Radius.circular(20.0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: Theme.of(context).inputDecorationTheme.focusedBorder!.borderSide,
          borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(20.0), bottomRight: Radius.circular(20.0)),
        ),
      ),
    );
  }
}
