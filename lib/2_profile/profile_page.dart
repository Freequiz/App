import 'package:flutter/material.dart';
import 'package:freequiz/api/api.dart';
import 'package:freequiz/others/initial_loading.dart';
import 'package:freequiz/others/loading_screen.dart';
import 'package:freequiz/2_profile/profile.dart';
import 'package:freequiz/2_profile/profile_info.dart';
import 'package:freequiz/2_profile/signup.dart';

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
      child: Profile.sessionToken == ""
          ? SignUp(
              refresh: refresh,
            )
          : FutureBuilder<Map>(
              future: httpGetProfile(Profile.sessionToken),
              builder: (context, data) {
                if (data.hasData) {
                  return LoadingScreen(
                    message: "Loading Profile",
                    finishedLoading: true,
                    widget: ProfileInfo(
                      refresh: refresh,
                      data: data.data!
                    ),
                    appBar: AppBar(
                      title: Text(language["Profile"]),
                    ),
                  );
                } else if (data.hasError) {
                  return Text('${data.error}');
                }
                return LoadingScreen(
                  message: "Loading Profile",
                  finishedLoading: false,
                  widget: ProfileInfo(
                    refresh: refresh,
                    data: data.data!
                  ),
                  appBar: AppBar(
                    title: Text(language["Loading"]),
                  ),
                );
              }),
    );
  }
}
