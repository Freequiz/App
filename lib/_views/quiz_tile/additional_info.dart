import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:freequiz/_views/badge.dart';
import 'package:freequiz/others/device_info.dart';
import 'package:freequiz/others/style.dart';
import 'package:freequiz/utilities/space.dart';

class AdditionalInfo extends StatelessWidget {
  const AdditionalInfo({super.key, required this.data});

  final Map data;
  final arrow = '\u279C';

  @override
  Widget build(BuildContext context) {
    return Container(
      height: DeviceInfo().height() / 30 + 15,
      padding: const EdgeInsets.only(top: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InfoBadge(
            color: roseFreequiz,
            text:'amount questions'.plural(data['translations'] ?? data['data'].length),
          ),

          Space.width(10.0),

          InfoBadge(
            color: purpleFreequiz,
            text:
            context.tr("fromto", args: [context.tr(data['from']['name']), context.tr(data['to']['name'])])
          ),
        ],
      ),
    );
  }
}
