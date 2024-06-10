import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:freequiz/_views/quiz_tile/draft.dart';
import 'package:freequiz/others/device_info.dart';
import 'package:freequiz/utilities/extensions/context_extensions.dart';
import 'package:freequiz/utilities/widgets/space.dart';

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
            context.tr('draft'),
            style: TextStyle(
                fontSize: context.screenHeight/ 30, color: Colors.white),
          ),
        ),
        Space.height(DeviceInfo.mobileLayout ? 5 : 15),
        DraftTile(
          refresh: refresh,
        ),
        Space.height(DeviceInfo.mobileLayout ? 15 : 45),
      ],
    );
  }
}
