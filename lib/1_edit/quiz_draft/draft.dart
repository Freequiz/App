import 'package:flutter/material.dart';
import 'package:freequiz/1_edit/quiz_draft/draft_tile.dart';
import 'package:freequiz/others/device_info.dart';
import 'package:freequiz/others/initial_loading.dart';

class Draft extends StatelessWidget {
  final Function refresh;
  const Draft({super.key, required this.refresh});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            language["Draft"],
            style: TextStyle(
                fontSize: DeviceInfo().height() / 30, color: Colors.white),
          ),
        ),
        SizedBox(
          height: DeviceInfo.mobileLayout ? 5 : 15,
        ),
        DraftTile(
          refresh: refresh,
        ),
        SizedBox(
          height: DeviceInfo.mobileLayout ? 15 : 45,
        ),
      ],
    );
  }
}
