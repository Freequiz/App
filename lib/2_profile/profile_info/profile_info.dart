import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:freequiz/2_profile/profile_info/confirmation.dart';
import 'package:freequiz/2_profile/profile_info/dark_mode_switcher.dart';
import 'package:freequiz/2_profile/profile_info/email.dart';
import 'package:freequiz/2_profile/profile_info/password.dart';
import 'package:freequiz/2_profile/profile_info/username.dart';
import 'package:freequiz/others/device_info.dart';
import 'package:freequiz/2_profile/profile.dart';
import 'package:freequiz/others/style.dart';

class ProfileInfo extends StatefulWidget {
  final Function refresh;
  final Map data;
  const ProfileInfo({super.key, required this.refresh, required this.data});

  @override
  State<ProfileInfo> createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {

  @override
  Widget build(BuildContext context) {
    final textColor =
        DeviceInfo.darkMode ? Colors.white : const Color.fromARGB(255, 40, 40, 40);
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
              fontSize: DeviceInfo().height() / 50,
              color: textColor,
            ),
            child: ListView(
              children: [
                SizedBox(height: DeviceInfo().height() / 60),
                Username(data: widget.data, refresh: widget.refresh),
                SizedBox(height: DeviceInfo().height() / 60),
                EMail(data: widget.data, refresh: widget.refresh),
                SizedBox(height: DeviceInfo().height() / 60),
                Password(refresh: widget.refresh),
                SizedBox(height: DeviceInfo().height() / 60),
                const DarkModeSwitcher(),
                SizedBox(height: DeviceInfo().height() / 60),
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
