import 'package:flutter/material.dart';
import 'package:freequiz/_views/switcher/switcher.dart';
import 'package:freequiz/utilities/providers/theme.dart';
import 'package:freequiz/utilities/extensions/context_extensions.dart';
import 'package:provider/provider.dart';

class DarkModeSwitcher extends StatefulWidget {
  const DarkModeSwitcher({super.key});

  @override
  State<DarkModeSwitcher> createState() => _DarkModeSwitcherState();
}

class _DarkModeSwitcherState extends State<DarkModeSwitcher> {
  String theme = ThemeProvider().getTheme();

  @override
  Widget build(BuildContext context) {
    return Switcher(
      onTap: onTap,
      texts: const ["Dark Mode", "Automatic", "Light Mode"],
      value: theme,
      width: context.screenWidth - 20,
    );
  }

  onTap(String value) {
    setState(() {
      theme = value;
    });
    Provider.of<ThemeProvider>(context, listen: false).toggleTheme(value);
  }
}
