import 'package:easy_localization/easy_localization.dart';
import 'package:freequiz/_views/subviews/buttons/submit.dart';
import 'package:freequiz/_views/subviews/textfields/password.dart';
import 'package:freequiz/_views/subviews/textfields/password_confirmation.dart';
import 'package:freequiz/models/textfield_data.dart';
import 'package:freequiz/services/api/users.dart';
import 'package:freequiz/utilities/imports/utilities.dart';

class Password extends StatefulWidget {
  final Function refresh;
  const Password({super.key, required this.refresh});

  @override
  State<Password> createState() => _PasswordState();
}

class _PasswordState extends State<Password> {
  TextFieldData newPassword = TextFieldData(hint: 'password'.tr(), shown: false);
  TextFieldData newPasswordConfirmation = TextFieldData(hint: 'confirm password'.tr(), shown: false);
  TextFieldData oldPassword = TextFieldData(hint: 'old password'.tr(), shown: false);
  bool edit = false;
  bool pressed = false;

  late FocusNode focusNode;

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
  }

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
                  'password',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ).tr(),
                const Spacer(),
                const Text("· · · · · · · ·"),
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
              widget: SizedBox(height: context.screenHeight / 60),
            ),
            Conditional(
              condition: edit,
              widget: PasswordTextfield(
                password: oldPassword,
                focusNode: focusNode,
                textInputAction: TextInputAction.next,
                autofillHints: const [AutofillHints.newPassword],
              ),
            ),
            Conditional(condition: edit, widget: Space.height(5.0)),
            Conditional(
              condition: edit,
              widget: PasswordTextfield(
                password: newPassword,
                focusNode: focusNode,
                textInputAction: TextInputAction.next,
                autofillHints: const [AutofillHints.newPassword],
              ),
            ),
            Conditional(
              condition: edit,
              widget: Space.height(5.0),
            ),
            Conditional(
              condition: edit,
              widget: IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Flexible(
                      child: PasswordConfirmationTextfield(
                        passwordConfirmation: newPasswordConfirmation,
                        onSubmitted: () => changePassword,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    SubmitButton(
                      pressed: pressed,
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        changePassword();
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

  changePassword() async {
    pressed = true;
    final Map map = await APIUsers.updateAccount(
        password: newPassword.input.text,
        passwordConfirmation: newPasswordConfirmation.input.text,
        oldPassword: oldPassword.input.text);
    if (map["success"] == true) {
      setState(() {
        newPassword.input.clear();
        newPasswordConfirmation.input.clear();
        oldPassword.input.clear();
        oldPassword.hint = 'password change'.tr();
        newPassword.hint = 'successfully'.tr();
        newPasswordConfirmation.hint = "";
        oldPassword.color = Colors.green;
        newPassword.color = Colors.green;
        newPasswordConfirmation.color = Colors.green;
        oldPassword.error = false;
      });
    }
    else if (map["message"] == "Password doesn't meet requirements") {
      setState(() {
        newPassword.input.clear();
        newPasswordConfirmation.input.clear();
        newPassword.hint = 'password length 1'.tr();
        newPasswordConfirmation.hint = 'password length 2'.tr();
        newPassword.color = Colors.red;
        newPassword.error = true;
        newPasswordConfirmation.color = Colors.red;
        newPasswordConfirmation.error = true;
      });
    }
    else if (map["errors"].containsKey("password_challenge")) {
      setState(() {
        oldPassword.input.clear();
        oldPassword.hint = 'wrong password'.tr();
        oldPassword.color = Colors.red;
        oldPassword.error = true;
      });
    }
    else if (map["errors"].containsKey("password_confirmation")) {
      setState(() {
        newPassword.input.clear();
        newPasswordConfirmation.input.clear();
        newPassword.hint = 'password dont match'.tr();
        newPasswordConfirmation.hint = "";
        newPassword.color = Colors.red;
        newPassword.error = true;
        newPasswordConfirmation.color = Colors.red;
        newPasswordConfirmation.error = true;
      });
    } 
    pressed = false;
  }
}
