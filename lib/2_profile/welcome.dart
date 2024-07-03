import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:freequiz/2_profile/login.dart';
import 'package:freequiz/2_profile/signup.dart';
import 'package:freequiz/utilities/imports/utilities.dart';

class Welcome extends StatelessWidget {
  final Function refresh;
  const Welcome({super.key, required this.refresh});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Padding(
        padding: context.mobileLayout
            ? const EdgeInsets.symmetric(horizontal: 20.0, vertical: 60.0)
            : EdgeInsets.symmetric(horizontal: context.screenWidth / 5.5, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Space.height(10.0),
            Text(
              context.tr('welcome'),
              style: fontSize(FontSize.headline),
            ),
            Space.height(5.0),
            Text(
              context.tr('welcome text'),
              textAlign: TextAlign.center,
              style: fontSize(FontSize.text),
            ),
            Space.height(50.0),
            Image.asset(
              'assets/images/icon_transparent.png',
              width: context.screenHeight / 4,
              height: context.screenHeight / 4,
            )
                .animate(
                  onPlay: (controller) => controller.repeat(),
                )
                .shimmer(duration: const Duration(milliseconds: 1500))
                .then(duration: const Duration(milliseconds: 1500)),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                button(context, Login(refresh: refresh), 'log in', roseLight),
                button(context, SignUp(refresh: refresh), 'sign up', blueLight),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget button(BuildContext context, Widget widget, String text, Color backgroundColor) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: gray55,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) {
              return widget;
            },
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
        child: Text(
          text,
          style: buttonStyle(),
        ).tr(),
      ),
    );
  }
}
