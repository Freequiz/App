import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:freequiz/others/device_info.dart';
import 'package:freequiz/models/textfield_data.dart';
import 'package:freequiz/api/users.dart';
import 'package:freequiz/others/style.dart';
import 'package:freequiz/utilities/conditional.dart';

class EMail extends StatefulWidget {
  final Function refresh;
  final Map data;
  const EMail({super.key, required this.data, required this.refresh});

  @override
  State<EMail> createState() => _EMailState();
}

class _EMailState extends State<EMail> {
  TextFieldData newEmail = TextFieldData(hint: 'email'.tr());
  bool edit = false;

  @override
  Widget build(BuildContext context) {
    final textColor = DeviceInfo.darkMode ? Colors.white : gray40;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(DeviceInfo().height() / 100),
        color: DeviceInfo.darkMode ? gray55 : white235,
      ),
      child: Padding(
        padding: EdgeInsets.all(DeviceInfo().height() / 100),
        child: Column(
          children: [
            Row(
              children: [
                const Text('email').tr(),
                const Spacer(),
                Text(widget.data["data"]["email"]),
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      edit = !edit;
                    });
                  },
                  child: Icon(
                    edit ? Icons.clear : Icons.edit,
                    color: textColor,
                  ),
                ),
              ],
            ),
            Conditional(
              condition: edit,
              widget: SizedBox(height: DeviceInfo().height() / 60),
            ),
            Conditional(
              condition: edit,
              widget: Row(
                children: [
                  Flexible(
                    child: SizedBox(
                      height: DeviceInfo().height() / 20,
                      child: TextField(
                        onSubmitted: (value) {
                          changeEmail();
                        },
                        keyboardAppearance: DeviceInfo.darkMode
                            ? Brightness.dark
                            : Brightness.light,
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                        controller: newEmail.input,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: DeviceInfo.darkMode
                              ? const Color.fromARGB(255, 45, 45, 45)
                              : const Color.fromARGB(255, 255, 231, 218),
                          contentPadding: const EdgeInsets.all(10.0),
                          hintText: newEmail.hint,
                          hintStyle: TextStyle(
                            color: newEmail.error
                                ? Colors.red
                                : (newEmail.changed ? Colors.green : textColor),
                          ),
                          border: const OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: newEmail.color,
                              width: 2.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  SizedBox(
                    height: DeviceInfo().height() / 20,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: grayFreequiz,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        changeEmail();
                      },
                      child: const Icon(Icons.arrow_forward_ios),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  changeEmail() async {
    if (newEmail.input.text.isEmpty) {
      newEmail.hint = 'blank'.tr();
    } else {
      final Map map =
          await APIUsers.updateAccount(email: newEmail.input.text);
      if (map["success"] == true) {
        setState(() {
          newEmail.input.clear();
          newEmail.hint = 'email success'.tr();
          newEmail.color = Colors.green;
          newEmail.error = false;
          newEmail.changed = true;
        });
        widget.refresh();
      } else if (map["message"] == "Invalid email") {
        setState(() {
          newEmail.input.clear();
          newEmail.hint = 'invalid email'.tr();
          newEmail.color = Colors.red;
          newEmail.error = true;
          newEmail.changed = false;
        });
      } else if (map["message"] == "Email is taken") {
        setState(() {
          newEmail.input.clear();
          newEmail.hint = 'email taken'.tr();
          newEmail.color = Colors.red;
          newEmail.error = true;
          newEmail.changed = false;
        });
      }
    }
  }
}
