import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:freequiz/2_profile/profile_info/confirmation.dart';
import 'package:freequiz/2_profile/profile_info/dark_mode_switcher.dart';
import 'package:freequiz/2_profile/profile_info/email.dart';
import 'package:freequiz/2_profile/profile_info/password.dart';
import 'package:freequiz/2_profile/profile_info/username.dart';
import 'package:freequiz/2_profile/profile.dart';
import 'package:freequiz/others/style.dart';
import 'package:freequiz/utilities/extensions/context_extensions.dart';

class ProfileInfo extends StatefulWidget {
  final Function refresh;
  const ProfileInfo({super.key, required this.refresh});

  @override
  State<ProfileInfo> createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {

  @override
  Widget build(BuildContext context) {
    final textColor =
        context.darkMode ? Colors.white : gray40;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: DefaultTextStyle(
            style: TextStyle(
              fontSize: context.screenHeight/ 50,
              color: textColor,
            ),
            child: ListView(
              children: [
                SizedBox(height: context.screenHeight/ 60),
                Username(refresh: widget.refresh),
                SizedBox(height: context.screenHeight/ 60),
                EMail(refresh: widget.refresh),
                SizedBox(height: context.screenHeight/ 60),
                Password(refresh: widget.refresh),
                SizedBox(height: context.screenHeight/ 60),
                const DarkModeSwitcher(),
                SizedBox(height: context.screenHeight/ 60),
                Align(
                  child: TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: grayFreequiz, foregroundColor: Colors.white),
                    onPressed: () async {
                      Profile.accessToken = "";
                      widget.refresh();
                      Profile.deleteData();
                    },
                    child: const Text('logout').tr(),
                  ),
                ),
                const SizedBox(height: 20.0,),
                Align(
                  child: TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white),
                    onPressed: () async {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) => Confirmation(refresh: widget.refresh));
                    },
                    child: const Text('delete account').tr(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
