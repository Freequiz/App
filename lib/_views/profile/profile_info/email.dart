import 'package:easy_localization/easy_localization.dart';
import 'package:freequiz/_views/subviews/buttons/submit.dart';
import 'package:freequiz/_views/subviews/textfields/email.dart';
import 'package:freequiz/models/textfield_data.dart';
import 'package:freequiz/services/api/users.dart';
import 'package:freequiz/controllers/user/helper.dart';
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
  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    final textColor = context.darkMode ? Colors.white : gray40;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(context.screenHeight / 100),
        color: context.darkMode ? gray55 : white235,
      ),
      child: Padding(
        padding: EdgeInsets.all(context.screenHeight / 100),
        child: Column(
          children: [
            Row(
              children: [
                const Text(
                  'email',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ).tr(),
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
            Visibility(
              visible: edit,
              child: SizedBox(height: context.screenHeight / 60),
            ),
            Visibility(
              visible: edit,
              child: IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
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
                    SubmitButton(
                      pressed: pressed,
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        changeEmail();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  changeEmail() async {
    pressed = true;
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
      } else if (map["token"] == "record.invalid") {
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
    pressed = false;
  }
}
