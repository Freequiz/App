import 'package:flutter/material.dart';
import 'package:freequiz/2_profile/profile_info/dark_mode_switcher/mode_button.dart';
import 'package:freequiz/others/device_info.dart';
import 'package:freequiz/others/style.dart';

class DarkModeSwitcher extends StatefulWidget {
  const DarkModeSwitcher({super.key});

  @override
  State<DarkModeSwitcher> createState() => _DarkModeSwitcherState();
}

class _DarkModeSwitcherState extends State<DarkModeSwitcher> {

  refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: DeviceInfo.width - 20,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(DeviceInfo.height / 100),
        color: DeviceInfo.darkMode ? backgroundGray : backgroundWhite,
      ),
      child: Row(
        children: const [
          ModeButton(value: "Dark Mode"),
          ModeButton(value: "Automatic"),
          ModeButton(value: "Light Mode")
        ],
      ),
    );
  }
}
