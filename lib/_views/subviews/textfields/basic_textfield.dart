import 'package:freequiz/models/textfield_data.dart';
import 'package:freequiz/utilities/imports/base.dart';

class BasicTextfield extends StatelessWidget {
  final TextFieldData data;
  final Function onSubmitted;
  final bool obscureText;
  final Widget? suffixIcon;
  final TextInputAction? textInputAction;
  final TextInputType? textInputType;
  final Iterable<String>? autofillHints;

  const BasicTextfield({
    super.key,
    required this.data,
    required this.onSubmitted,
    this.obscureText = false,
    this.suffixIcon,
    this.textInputAction,
    this.textInputType,
    this.autofillHints
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      onSubmitted: (value) => onSubmitted(),
      autofillHints: autofillHints,
      textInputAction: textInputAction,
      autocorrect: false,
      enableSuggestions: false,
      obscureText: obscureText,
      keyboardType: textInputType,
      controller: data.input,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(10.0),
        hintStyle: data.error ? const TextStyle(color: Colors.red) : null,
        suffixIcon: suffixIcon,
        hintText: data.hint,
        border: const OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: data.color,
            width: 2.0,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(10.0))
        ),
      ),
    );
  }
}
