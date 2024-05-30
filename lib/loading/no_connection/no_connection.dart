import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:freequiz/others/device_info.dart';

class NoConnectionAlert extends StatelessWidget {

  final Function onClose;

  const NoConnectionAlert(
      {super.key, required this.onClose});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        context.tr('no connection title'),
        style: TextStyle(color: DeviceInfo.darkMode ? Colors.white : Colors.black),
      ),
      content: const Text('no connection description').tr(),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('close').tr(),
        ),
      ],
    );
  }
}