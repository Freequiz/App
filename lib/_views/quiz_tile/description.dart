import 'package:flutter/material.dart';
import 'package:freequiz/others/device_info.dart';

class Description extends StatelessWidget {
  const Description(
      {super.key,
      required this.expanded,
      required this.width,
      required this.description});

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
        description,
        maxLines: expanded ? 2 : 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: DeviceInfo().height() / 60,
        ),
      ),
    );
  }
}
