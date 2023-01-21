import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:freequiz/others/device_info.dart';
import 'package:freequiz/others/initial_loading.dart';
import 'package:freequiz/others/style.dart';
import 'package:freequiz/others/theme.dart';
import 'package:provider/provider.dart';

class ModeButton extends StatefulWidget {
  final String value;
  const ModeButton({super.key, required this.value});

  @override
  State<ModeButton> createState() => _ModeButtonState();
}

class _ModeButtonState extends State<ModeButton> {
  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<ThemeProvider>(context);
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        themeChange.theme = widget.value;
        Phoenix.rebirth(context);
      },
      child: Container(
        width: (DeviceInfo.width - 20) / 3,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(DeviceInfo.height / 100),
          color: DeviceInfo.theme== widget.value
              ? DeviceInfo.darkMode
                  ? highlightGray
                  : highlightWhite
              : const Color.fromARGB(0, 69, 69, 69),
        ),
        child: Center(
            child: Text(
          language[widget.value],
          style: TextStyle(fontSize: DeviceInfo.height / 60),
        )),
      ),
    );
  }
}
