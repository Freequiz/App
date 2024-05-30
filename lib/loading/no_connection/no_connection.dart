import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:freequiz/others/device_info.dart';
import 'package:freequiz/others/style.dart';

class NoConnectionAlert extends StatelessWidget {
  final Color backgroundColor;
  final bool showButton;

  const NoConnectionAlert({super.key, this.backgroundColor = gray40, this.showButton = true});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        context.tr('no connection title'),
        style: TextStyle(color: DeviceInfo.darkMode ? Colors.white : Colors.black),
      ),
      backgroundColor: backgroundColor,
      content: const Text('no connection description').tr(),
      actions: showButton
          ? [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('close').tr(),
              ),
            ]
          : null,
    );
  }
}
