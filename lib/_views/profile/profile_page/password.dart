import 'package:easy_localization/easy_localization.dart';
import 'package:freequiz/_views/subviews/buttons/submit.dart';
import 'package:freequiz/_views/subviews/textfields/password.dart';
import 'package:freequiz/_views/subviews/textfields/password_confirmation.dart';
import 'package:freequiz/controllers/profile/profile_page.dart';
import 'package:freequiz/utilities/imports/utilities.dart';
import 'package:provider/provider.dart';

class Password extends StatefulWidget {
  const Password({super.key});

  @override
  State<Password> createState() => _PasswordState();
}

class _PasswordState extends State<Password> {
  late FocusNode focusNode;

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<ProfilePageController>(context);

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
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: () => controller.toggleEditPassword(),
                  child: Icon(controller.icon(controller.editPassword)),
                ),
              ],
            ),
            Visibility(
              visible: controller.editPassword,
              child: SizedBox(height: context.screenHeight / 60),
            ),
            Visibility(
              visible: controller.editPassword,
              child: PasswordTextfield(
                password: controller.oldPassword,
                focusNode: focusNode,
                textInputAction: TextInputAction.next,
                autofillHints: const [AutofillHints.newPassword],
              ),
            ),
            Visibility(
                visible: controller.editPassword, child: Space.height(5.0)),
            Visibility(
              visible: controller.editPassword,
              child: PasswordTextfield(
                password: controller.newPassword,
                focusNode: focusNode,
                textInputAction: TextInputAction.next,
                autofillHints: const [AutofillHints.newPassword],
              ),
            ),
            Visibility(
              visible: controller.editPassword,
              child: Space.height(5.0),
            ),
            Visibility(
              visible: controller.editPassword,
              child: IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Flexible(
                      child: PasswordConfirmationTextfield(
                        passwordConfirmation:
                            controller.newPasswordConfirmation,
                        onSubmitted: () => controller.changePassword,
                      ),
                    ),
                    const SizedBox(width: 5),
                    SubmitButton(
                      pressed: controller.pressedPassword,
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        controller.changePassword();
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
}
