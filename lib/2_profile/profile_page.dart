import 'package:flutter/material.dart';
import 'package:freequiz/2_profile/profile.dart';
import 'package:freequiz/2_profile/profile_info/profile_info.dart';
import 'package:freequiz/2_profile/signup.dart';
import 'package:freequiz/api/users.dart';
import 'package:freequiz/loading/error_loading/error_loading2.dart';
import 'package:freequiz/loading/loading_screen/loading_screen2.dart';

import '../others/utilities.dart';

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
      child: conditional(
        Profile.accessToken == "",
        SignUp(
          refresh: refresh,
        ),
        defaultWidget: FutureBuilder<Map>(
          future: APIUsers.getData(),
          builder: (context, data) {
            if (data.hasData) {
              if (data.data!["success"]) {
                return LoadingScreen2(
                  message: "Loading Profile",
                  finishedLoading: true,
                  widget: ProfileInfo(refresh: refresh, data: data.data!),
                );
              }
              return Navigator(
                onGenerateRoute: (settings) => MaterialPageRoute(
                  builder: (context) => ErrorLoading2(
                      error: data.data!["message"],
                      previousWidget: const ProfilePage()),
                ),
              );
            } else if (data.hasError) {
              return Navigator(
                onGenerateRoute: (settings) => MaterialPageRoute(
                  builder: (context) => ErrorLoading2(
                      error: data.data!["message"],
                      previousWidget: const ProfilePage()),
                ),
              );
            }
            return const LoadingScreen2(
              message: "Loading Profile",
            );
          },
        ),
      ),
    );
  }
}
