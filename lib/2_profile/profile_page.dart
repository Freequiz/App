import 'package:flutter/material.dart';
import 'package:freequiz/2_profile/profile.dart';
import 'package:freequiz/2_profile/profile_info/profile_info.dart';
import 'package:freequiz/2_profile/signup.dart';
import 'package:freequiz/api/api_account.dart';
import 'package:freequiz/others/loading_screen2.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Profile.accessToken == ""
          ? SignUp(
              refresh: refresh,
            )
          : FutureBuilder<Map>(
              future: httpGetProfile(),
              builder: (context, data) {
                if (data.hasData) {
                  return LoadingScreen2(
                    message: "Loading Profile",
                    finishedLoading: true,
                    widget: ProfileInfo(
                      refresh: refresh,
                      data: data.data!
                    ),
                  );
                } else if (data.hasError) {
                  return Text('${data.error}');
                }
                return const LoadingScreen2(
                  message: "Loading Profile",
                  finishedLoading: false,
                  widget: Drawer(),
                );
              }),
    );
  }
}
