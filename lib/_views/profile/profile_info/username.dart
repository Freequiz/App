import 'package:easy_localization/easy_localization.dart';
import 'package:freequiz/_views/subviews/buttons/submit.dart';
import 'package:freequiz/_views/subviews/textfields/username.dart';
import 'package:freequiz/models/textfield_data.dart';
import 'package:freequiz/services/api/users.dart';
import 'package:freequiz/controllers/user/helper.dart';
import 'package:freequiz/utilities/imports/utilities.dart';

class Username extends StatefulWidget {
  final Function refresh;
  const Username({super.key, required this.refresh});

  @override
  State<Username> createState() => _UsernameState();
}

class _UsernameState extends State<Username> {
  bool edit = false;
  bool pressed = false;
  TextFieldData newUsername = TextFieldData(hint: 'username'.tr());

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
                  'username',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ).tr(),
                const Spacer(),
                Text(UserHelper.user!.username),
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
                      child: UsernameTextfield(
                        username: newUsername,
                        focusNode: FocusNode(),
                        onSubmitted: changeUsername,
                        autofillHints: const [AutofillHints.newUsername],
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    SubmitButton(
                      pressed: pressed,
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        changeUsername();
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

  changeUsername() async {
    pressed = true;
    final Map map = await APIUsers.updateAccount(username: newUsername.input.text);
    if (map["success"] == true) {
      setState(() {
        UserHelper.user!.username = newUsername.input.text;
        newUsername.input.clear();
        newUsername.hint = 'username change'.tr();
        newUsername.color = Colors.green;
        newUsername.error = false;
        newUsername.changed = true;
      });
      widget.refresh();
    } 
    else if (map["errors"]["username"][0]["error"] == "invalid") {
      setState(() {
        newUsername.input.clear();
        newUsername.hint = 'username invalid'.tr();
        newUsername.color = Colors.red;
        newUsername.error = true;
        newUsername.changed = false;
      });
    } else if (map["errors"]["username"][0]["error"] == "taken") {
      setState(() {
        newUsername.input.clear();
        newUsername.hint = 'username taken'.tr();
        newUsername.color = Colors.red;
        newUsername.error = true;
        newUsername.changed = false;
      });
    }
    pressed = false;
  }
}
