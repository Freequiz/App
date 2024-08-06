import 'package:freequiz/models/textfield_data.dart';
import 'package:freequiz/utilities/imports/base.dart';

class BasicTextField extends StatefulWidget {
  final TextFieldData textFieldData;
  final String hintError;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final int maxLines;
  final Function save;
  final Color? textFieldColor;
  final bool bottomRadius;
  const BasicTextField(
      {super.key,
      required this.textFieldData,
      required this.hintError,
      this.textFieldColor,
      this.keyboardType = TextInputType.text,
      this.textInputAction = TextInputAction.next,
      this.maxLines = 1,
      this.bottomRadius = false,
      required this.save});

  @override
  State<BasicTextField> createState() => _BasicTextFieldState();
}

class _BasicTextFieldState extends State<BasicTextField> {
  @override
  Widget build(BuildContext context) {
    final hintColor = context.darkMode ? Colors.white : gray40;

    Color? textfieldColor = widget.textFieldColor;
    if (widget.textFieldColor == null) {
      textfieldColor = context.darkMode ? gray55 : const Color.fromARGB(255, 234, 247, 255);
    }

    return TextField(
      onSubmitted: (value) {
        widget.save();
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
      keyboardAppearance: context.darkMode ? Brightness.dark : Brightness.light,
      maxLines: widget.maxLines,
      decoration: InputDecoration(
        filled: true,
        fillColor: textfieldColor,
        contentPadding: widget.bottomRadius ? const EdgeInsets.all(10.0) : const EdgeInsets.all(15.0),
        hintStyle: TextStyle(
          color: widget.textFieldData.error ? Colors.red : hintColor,
          fontWeight: FontWeight.w500,
          fontSize: FontSize.text,
        ),
        hintText: widget.textFieldData.error ? widget.hintError : widget.textFieldData.hint,
        border: const OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: widget.textFieldData.error ? Colors.red : textfieldColor!,
            width: 2.0,
          ),
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(20.0),
            topRight: const Radius.circular(20.0),
            bottomLeft: widget.bottomRadius ? const Radius.circular(20.0) : const Radius.circular(0.0),
            bottomRight: widget.bottomRadius ? const Radius.circular(20.0) : const Radius.circular(0.0),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: Theme.of(context).inputDecorationTheme.focusedBorder!.borderSide,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(20.0),
            topRight: const Radius.circular(20.0),
            bottomLeft: widget.bottomRadius ? const Radius.circular(20.0) : const Radius.circular(0.0),
            bottomRight: widget.bottomRadius ? const Radius.circular(20.0) : const Radius.circular(0.0),
          ),
        ),
      ),
    );
  }
}
