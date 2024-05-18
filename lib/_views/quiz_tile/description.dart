import 'package:flutter/material.dart';
import 'package:freequiz/others/device_info.dart';
import 'package:freequiz/others/string_extensions.dart';

class Description extends StatelessWidget {
  const Description({super.key, required this.expanded, required this.width, required this.description});

  final bool expanded;
  final double width;
  final String description;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: expanded
          ? DeviceInfo.mobileLayout
              ? width - 20
              : width - 40
          : DeviceInfo.mobileLayout
              ? width / 6 * 5 - 20
              : width / 6 * 5 - 40,
      child: Text(
        expanded
            ? description
            : description.toString().triming(32),
        style: TextStyle(
            fontSize: longDescription(description)
                ? DeviceInfo().height() / 60
                : DeviceInfo().height() / 50),
      ),
    );
  }

  bool longDescription(String? description) {
    if (description != null) {
      return description.length > 50;
    }
    return false;
  }
}
