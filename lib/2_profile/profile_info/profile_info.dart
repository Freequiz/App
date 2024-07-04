import 'package:freequiz/2_profile/profile_info/confirmation.dart';
import 'package:freequiz/2_profile/profile_info/dark_mode_switcher.dart';
import 'package:freequiz/2_profile/profile_info/email.dart';
import 'package:freequiz/2_profile/profile_info/password.dart';
import 'package:freequiz/2_profile/profile_info/username.dart';
import 'package:freequiz/2_profile/profile.dart';
import 'package:freequiz/_views/buttons/long_button.dart';
import 'package:freequiz/_views/category_title.dart';
import 'package:freequiz/utilities/imports/utilities.dart';
import 'package:material_symbols_icons/symbols.dart';

class ProfileInfo extends StatefulWidget {
  final Function refresh;
  const ProfileInfo({super.key, required this.refresh});

  @override
  State<ProfileInfo> createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.mobileLayout ? 10.0 : context.screenWidth / 5.5),
          child: ListView(
            children: [
              SizedBox(height: context.screenHeight / 60),
              CategoryTitle(icon: Symbols.dark_mode_rounded, color: rose, title: 'appearance'),
              const DarkModeSwitcher(),
              SizedBox(height: context.screenHeight / 60),
              CategoryTitle(icon: Symbols.person, color: purple, title: 'account'),
              Username(refresh: widget.refresh),
              const SizedBox(height: 10.0),
              EMail(refresh: widget.refresh),
              const SizedBox(height: 10.0),
              Password(refresh: widget.refresh),
              const SizedBox(height: 10.0),
              Row(
                children: [
                  LongButton(
                    onPressed: () async {
                      showDialog(
                          context: context, builder: (BuildContext context) => Confirmation(refresh: widget.refresh));
                    },
                    text: 'delete account',
                    color: context.darkMode ? redDark : redMedium,
                  ),
                  const SizedBox(
                    width: 15.0,
                  ),
                  LongButton(
                    onPressed: () async {
                      Profile.accessToken = "";
                      widget.refresh();
                      Profile.deleteData();
                    },
                    text: 'logout',
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
