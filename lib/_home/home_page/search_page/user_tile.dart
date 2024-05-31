import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:freequiz/_views/badge.dart';
import 'package:freequiz/_views/buttons/share.dart';
import 'package:freequiz/loading/load_user.dart';
import 'package:freequiz/others/device_info.dart';
import 'package:freequiz/others/style.dart';
import 'package:freequiz/others/utilities.dart';

class UserTile extends StatefulWidget {
  final Map data;
  final double width;
  const UserTile({super.key, required this.data, required this.width});

  @override
  State<UserTile> createState() => _UserTileState();
}

class _UserTileState extends State<UserTile> {
  @override
  Widget build(BuildContext context) {
    final color6 =
        DeviceInfo.darkMode ? gray55 : white235;

    final n = widget.data["quizzes"];

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => loadUser(context: context, user: widget.data['username']),
      child: Container(
        width: DeviceInfo().width() - 20,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(DeviceInfo().height() / 100),
          color: color6,
        ),
        child: Padding(
          padding: DeviceInfo.mobileLayout
              ? const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0, top: 5.0)
              : const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0, top: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: DeviceInfo().height() / 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.data['username'],
                      style: textSize(DeviceInfo().height() / 30),
                    ),
                    ShareButton(
                      url: "https://freequiz.herokuapp.com/user/${widget.data['username']}",
                      color: DeviceInfo.darkMode ? Colors.white : gray40,
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 15),
                height: DeviceInfo().height() / 30 + 15,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InfoBadge(
                      color: roseFreequiz,
                      text: 'amount quizzes'.plural(n),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
