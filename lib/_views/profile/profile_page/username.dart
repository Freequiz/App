import 'package:easy_localization/easy_localization.dart';
import 'package:freequiz/_views/subviews/buttons/submit.dart';
import 'package:freequiz/_views/subviews/textfields/username.dart';
import 'package:freequiz/controllers/profile/profile_page.dart';
import 'package:freequiz/controllers/profile/user.dart';
import 'package:freequiz/utilities/imports/utilities.dart';
import 'package:provider/provider.dart';

class Username extends StatefulWidget {
  const Username({super.key});

  @override
  State<Username> createState() => _UsernameState();
}

class _UsernameState extends State<Username> {
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
                  'username',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ).tr(),
                const Spacer(),
                Text(UserHelper.user!.username),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: () => controller.toggleEditUsername(),
                  child: Icon(controller.icon(controller.editUsername)),
                ),
              ],
            ),
            Visibility(
              visible: controller.editUsername,
              child: SizedBox(height: context.screenHeight / 60),
            ),
            Visibility(
              visible: controller.editUsername,
              child: IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Flexible(
                      child: UsernameTextfield(
                        username: controller.newUsername,
                        focusNode: FocusNode(),
                        onSubmitted: controller.changeUsername,
                        autofillHints: const [AutofillHints.newUsername],
                      ),
                    ),
                    const SizedBox(width: 5),
                    SubmitButton(
                      pressed: controller.pressedUsername,
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        controller.changeUsername();
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
