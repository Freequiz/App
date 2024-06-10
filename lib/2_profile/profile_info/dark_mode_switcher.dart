import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:freequiz/_views/switcher/switcher.dart';
import 'package:freequiz/others/device_info.dart';
import 'package:freequiz/others/theme.dart';
import 'package:freequiz/utilities/extensions/context_extensions.dart';
import 'package:provider/provider.dart';

class DarkModeSwitcher extends StatefulWidget {
  const DarkModeSwitcher({super.key});

  @override
  State<DarkModeSwitcher> createState() => _DarkModeSwitcherState();
}

class _DarkModeSwitcherState extends State<DarkModeSwitcher> {
  @override
  Widget build(BuildContext context) {
    return Switcher(
      onTap: onTap,
      texts: const ["Dark Mode", "Automatic", "Light Mode"],
      value: DeviceInfo.theme,
      width: context.screenWidth - 20,
    );
  }

  onTap(String value) {
    final themeChange = Provider.of<ThemeProvider>(context, listen: false);
    themeChange.theme = value;
    Phoenix.rebirth(context);
  }
}
