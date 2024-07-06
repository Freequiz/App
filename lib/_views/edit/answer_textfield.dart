import 'package:easy_localization/easy_localization.dart';
import 'package:freequiz/models/textfield_data.dart';
import 'package:freequiz/utilities/imports/base.dart';

class AnswerTextField extends StatefulWidget {
  final TextFieldData textFieldData;
  final double widthBorder;
  final Function onSubmitted;
  final Function save;
  const AnswerTextField(
      {super.key,
      required this.textFieldData,
      this.widthBorder = 2.0,
      required this.onSubmitted,
      required this.save});

  @override
  State<AnswerTextField> createState() => _AnswerTextFieldState();
}

class _AnswerTextFieldState extends State<AnswerTextField> {
  @override
  Widget build(BuildContext context) {
    final hintColor = context.darkMode
        ? Colors.white
        : gray40;
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
      keyboardAppearance:
          context.darkMode ? Brightness.dark : Brightness.light,
      decoration: InputDecoration(
        filled: true,
        fillColor: context.darkMode
            ? const Color.fromARGB(255, 45, 45, 45)
            : const Color.fromARGB(255, 234, 247, 255),
        contentPadding: const EdgeInsets.all(10.0),
        hintStyle: TextStyle(
          color: widget.textFieldData.error ? Colors.red : hintColor,
          fontWeight: FontWeight.w500,
        ),
        hintText: widget.textFieldData.error
            ? context.tr('answer blank')
            : widget.textFieldData.hint,
        border: const OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: widget.textFieldData.error ? Colors.red : grayFreequiz,
            width: widget.widthBorder,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(10.0))
        ),
      ),
    );
  }
}
