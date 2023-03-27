import 'package:flutter/material.dart';
import 'package:freequiz/_home/user_page/public_quizzes.dart';
import 'package:freequiz/others/device_info.dart';

class UserPage extends StatefulWidget {
  final String user;
  const UserPage({super.key, required this.user});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: DeviceInfo.mobileLayout
          ? const EdgeInsets.all(10.0)
          : const EdgeInsets.all(20.0),
      child: PublicQuizzes(
        user: widget.user,
      ),
    );
  }
}
