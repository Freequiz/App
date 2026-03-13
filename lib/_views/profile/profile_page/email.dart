import 'package:easy_localization/easy_localization.dart';
import 'package:freequiz/_views/subviews/buttons/submit.dart';
import 'package:freequiz/_views/subviews/textfields/email.dart';
import 'package:freequiz/controllers/profile/profile_page.dart';
import 'package:freequiz/controllers/profile/user.dart';
import 'package:freequiz/utilities/imports/utilities.dart';
import 'package:provider/provider.dart';

class EMail extends StatefulWidget {
  const EMail({super.key});

  @override
  State<EMail> createState() => _EMailState();
}

class _EMailState extends State<EMail> {
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
                  'email',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ).tr(),
                const Spacer(),
                Text(UserHelper.user!.email),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: () => controller.toggleEditEmail(),
                  child: Icon(controller.icon(controller.editEmail)),
                ),
              ],
            ),
            Visibility(
              visible: controller.editEmail,
              child: SizedBox(height: context.screenHeight / 60),
            ),
            Visibility(
              visible: controller.editEmail,
              child: IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Flexible(
                      child: EmailTextfield(
                        email: controller.newEmail,
                        focusNode: FocusNode(),
                        onSubmitted: controller.changeEmail,
                      ),
                    ),
                    const SizedBox(width: 5),
                    SubmitButton(
                      pressed: controller.pressedEmail,
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        controller.changeEmail();
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
