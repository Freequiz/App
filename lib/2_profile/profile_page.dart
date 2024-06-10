import 'package:flutter/material.dart';
import 'package:freequiz/2_profile/profile.dart';
import 'package:freequiz/2_profile/profile_info/profile_info.dart';
import 'package:freequiz/2_profile/signup.dart';
import 'package:freequiz/loading/error_loading/alert.dart';
import 'package:freequiz/loading/loading_screen/animation.dart';
import 'package:freequiz/user/manage.dart';
import 'package:freequiz/utilities/conditional.dart';

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
      child: Conditional(
        condition: Profile.accessToken == "",
        widget: SignUp(
          refresh: refresh,
        ),
        defaultWidget: FutureBuilder<Map>(
          future: ManageUser.load(),
          builder: (context, data) {
            if (data.hasData) {
              if (data.data!["success"]) {
                return LoadingAnimation(
                  message: "Loading Profile",
                  finishedLoading: true,
                  widget: ProfileInfo(refresh: refresh),
                );
              }
              return Navigator(
                onGenerateRoute: (settings) => MaterialPageRoute(
                  builder: (context) => ErrorLoadingAlert(
                      error: data.data!["message"],
                      previousWidget: const ProfilePage()),
                ),
              );
            } else if (data.hasError) {
              return Navigator(
                onGenerateRoute: (settings) => MaterialPageRoute(
                  builder: (context) => ErrorLoadingAlert(
                      error: data.data!["message"],
                      previousWidget: const ProfilePage()),
                ),
              );
            }
            return const LoadingAnimation(
              message: "Loading Profile",
            );
          },
        ),
      ),
    );
  }
}
