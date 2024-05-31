import 'package:flutter/material.dart';
import 'package:freequiz/models/textfield_data.dart';
import 'package:freequiz/others/device_info.dart';

class BasicTextfield extends StatelessWidget {
  final TextFieldData data;
  final Function onSubmitted;
  final bool obscureText;
  final Widget? suffixIcon;
  final TextInputAction? textInputAction;
  final TextInputType? textInputType;

  const BasicTextfield({
    super.key,
    required this.data,
    required this.onSubmitted,
    this.obscureText = false,
    this.suffixIcon,
    this.textInputAction,
    this.textInputType,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: DeviceInfo.mobileLayout ? DeviceInfo().height() / 20 : 40,
      child: TextField(
        onSubmitted: (value) => onSubmitted(),
        keyboardAppearance: DeviceInfo.darkMode ? Brightness.dark : Brightness.light,
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
          ),
        ),
      ),
    );
  }
}
