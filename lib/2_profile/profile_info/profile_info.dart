import 'package:flutter/material.dart';
import 'package:freequiz/2_profile/profile_info/confirmation.dart';
import 'package:freequiz/2_profile/profile_info/email.dart';
import 'package:freequiz/2_profile/profile_info/password.dart';
import 'package:freequiz/2_profile/profile_info/username.dart';
import 'package:freequiz/others/initial_loading.dart';
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
    double height = MediaQuery.of(context).size.height;
    final brightness = MediaQuery.of(context).platformBrightness;
    bool darkMode = brightness == Brightness.dark;
    final textColor =
        darkMode ? Colors.white : const Color.fromARGB(255, 40, 40, 40);
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: DefaultTextStyle(
            style: TextStyle(
              fontSize: height / 50,
              color: textColor,
            ),
            child: ListView(
              children: [
                SizedBox(height: height / 60),
                Username(data: widget.data, refresh: widget.refresh),
                SizedBox(height: height / 60),
                EMail(data: widget.data, refresh: widget.refresh),
                SizedBox(height: height / 60),
                Password(refresh: widget.refresh),
                SizedBox(height: height / 60),
                Align(
                  child: TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: color1, foregroundColor: Colors.white),
                    onPressed: () async {
                      Profile.accessToken = "";
                      widget.refresh();
                      Profile().deleteData();
                    },
                    child: Text(language["Logout"]),
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
                    child: Text(language["Delete Account"]),
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
