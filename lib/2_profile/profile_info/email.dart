import 'package:easy_localization/easy_localization.dart';
import 'package:freequiz/_views/textfields/email.dart';
import 'package:freequiz/models/textfield_data.dart';
import 'package:freequiz/api/users.dart';
import 'package:freequiz/user/helper.dart';
import 'package:freequiz/utilities/imports/utilities.dart';

class EMail extends StatefulWidget {
  final Function refresh;
  const EMail({super.key, required this.refresh});

  @override
  State<EMail> createState() => _EMailState();
}

class _EMailState extends State<EMail> {
  TextFieldData newEmail = TextFieldData(hint: 'email'.tr());
  bool edit = false;

  @override
  Widget build(BuildContext context) {
    final textColor = context.darkMode ? Colors.white : gray40;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(context.screenHeight/ 100),
        color: context.darkMode ? gray55 : white235,
      ),
      child: Padding(
        padding: EdgeInsets.all(context.screenHeight/ 100),
        child: Column(
          children: [
            Row(
              children: [
                const Text('email').tr(),
                const Spacer(),
                Text(UserHelper.user!.email),
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
              widget: SizedBox(height: context.screenHeight/ 60),
            ),
            Conditional(
              condition: edit,
              widget: Row(
                children: [
                  Flexible(
                    child: EmailTextfield(
                      email: newEmail,
                      focusNode: FocusNode(),
                      onSubmitted: changeEmail,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  SizedBox(
                    height: context.screenHeight/ 20,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: grayFreequiz,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        FocusScope.of(context).unfocus();
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
      final Map map = await APIUsers.updateAccount(email: newEmail.input.text);
      if (map["success"] == true) {
        setState(() {
          UserHelper.user!.email = newEmail.input.text;
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
