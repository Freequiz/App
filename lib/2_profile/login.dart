import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:freequiz/_views/buttons/submit.dart';
import 'package:freequiz/_views/textfields/password.dart';
import 'package:freequiz/_views/textfields/username.dart';
import 'package:freequiz/others/device_info.dart';
import 'package:freequiz/models/textfield_data.dart';
import 'package:freequiz/api/users.dart';
import 'package:freequiz/2_profile/profile.dart';
import 'package:freequiz/others/utilities.dart';
import 'package:freequiz/utilities/space.dart';

class Login extends StatefulWidget {
  final Function refresh;
  const Login({super.key, required this.refresh});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextFieldData username = TextFieldData(hint: 'username'.tr());
  final password = TextFieldData(hint: 'password'.tr(), shown: false);
  bool pressed = false;

  late Map mapLogin;
  late FocusNode focusNode;

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('sign up').tr(),
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Padding(
          padding: DeviceInfo.mobileLayout
              ? const EdgeInsets.all(10.0)
              : EdgeInsets.symmetric(horizontal: DeviceInfo().width() / 5.5, vertical: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Space.height(DeviceInfo().height() / 60),
              Text(
                context.tr('login'),
                style: textSize(DeviceInfo().height() / 20),
              ),
              Space.height(DeviceInfo().height() / 60),
              UsernameTextfield(username: username, focusNode: focusNode),
              Space.height(5),
              Row(
                children: [
                  Flexible(
                    child: PasswordTextfield(
                      password: password,
                      onPressed: onPressed,
                    ),
                  ),
                  Space.width(5),
                  SubmitButton(pressed: pressed, onPressed: onPressed)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  onPressed() async {
    if (password.input.text.isEmpty) {
      setState(() {
        password.error = true;
        password.hint = context.tr('wrong password');
      });
    } else if (username.input.text.isEmpty) {
      setState(() {
        username.error = true;
        username.hint = context.tr('username error');
      });
    } else {
      setState(() {
        pressed = true;
      });
      mapLogin = await APIUsers.login(username.input.text.trim(), password.input.text.trim());
      if (mapLogin.isNotEmpty) {
        if (mapLogin["message"] == "User doesn't exist") {
          setState(() {
            username.error = true;
            pressed = false;
            username.input.clear();
          });
        } else if (mapLogin["message"] == "Wrong password") {
          setState(() {
            password.error = true;
            pressed = false;
            password.input.clear();
          });
        } else {
          Profile.accessToken = mapLogin["access_token"];
          Profile.saveData();
          // ignore: use_build_context_synchronously
          Navigator.of(context).pop();
          widget.refresh();
        }
      }
    }
  }
}
