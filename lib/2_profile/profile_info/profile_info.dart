import 'package:easy_localization/easy_localization.dart';
import 'package:freequiz/2_profile/profile_info/confirmation.dart';
import 'package:freequiz/2_profile/profile_info/dark_mode_switcher.dart';
import 'package:freequiz/2_profile/profile_info/email.dart';
import 'package:freequiz/2_profile/profile_info/password.dart';
import 'package:freequiz/2_profile/profile_info/username.dart';
import 'package:freequiz/2_profile/profile.dart';
import 'package:freequiz/utilities/imports/utilities.dart';

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
              Username(refresh: widget.refresh),
              SizedBox(height: context.screenHeight / 60),
              EMail(refresh: widget.refresh),
              SizedBox(height: context.screenHeight / 60),
              Password(refresh: widget.refresh),
              SizedBox(height: context.screenHeight / 60),
              const DarkModeSwitcher(),
              SizedBox(height: context.screenHeight / 5),
              Align(
                child: TextButton(
                  style: TextButton.styleFrom(backgroundColor: grayFreequiz, foregroundColor: Colors.white),
                  onPressed: () async {
                    Profile.accessToken = "";
                    widget.refresh();
                    Profile.deleteData();
                  },
                  child: Text(
                    'logout',
                    style: buttonStyle(),
                  ).tr(),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Align(
                child: TextButton(
                  style: TextButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white),
                  onPressed: () async {
                    showDialog(
                        context: context, builder: (BuildContext context) => Confirmation(refresh: widget.refresh));
                  },
                  child: Text(
                    'delete account',
                    style: buttonStyle(),
                  ).tr(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
