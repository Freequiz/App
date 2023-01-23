import 'package:flutter/material.dart';
import 'package:freequiz/1_edit/edit_create_quiz/edit_quiz.dart';
import 'package:freequiz/quiz.dart';
import 'package:freequiz/others/device_info.dart';
import 'package:freequiz/others/initial_loading.dart';
import 'package:freequiz/others/style.dart';
import 'package:share_plus/share_plus.dart';

class KebabMenuButton extends StatelessWidget {
  final String url;
  final Color color;
  final String uuid;
  const KebabMenuButton(
      {super.key,
      required this.url,
      this.color = Colors.white,
      required this.uuid});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        foregroundColor: Colors.white,
      ),
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => KebabMenu(
            url: url,
            uuid: uuid,
          ),
        );
      },
      child: Icon(
        Icons.more_vert_rounded,
        color: color,
      ),
    );
  }
}

class KebabMenu extends StatefulWidget {
  final String url;
  final String uuid;
  const KebabMenu({super.key, required this.url, required this.uuid});

  @override
  State<KebabMenu> createState() => _KebabMenuState();
}

class _KebabMenuState extends State<KebabMenu> {
  refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actionsPadding: const EdgeInsets.symmetric(vertical: 2.0),
      buttonPadding: const EdgeInsets.all(0.0),
      actions: [
        KebabMenuItem(
          onTap: () => share,
          icon: Icons.ios_share_rounded,
          text: "Share",
        ),
        Container(
          color: DeviceInfo.darkMode ? textGray : highlightWhite,
          height: 2.0,
        ),
        KebabMenuItem(
          onTap: () => edit,
          icon: Icons.edit,
          text: "Edit",
        ),
        Container(
          color: DeviceInfo.darkMode ? textGray : highlightWhite,
          height: 2.0,
        ),
        KebabMenuItem(
          onTap: () => close,
          icon: Icons.close,
          text: "Close",
        ),
      ],
    );
  }

  close() {
    Navigator.of(context).pop();
  }

  edit() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return EditQuiz(refresh: refresh, uuid: widget.uuid, owner: Quiz.mapQuiz['quiz_data']['owner'],);
        },
      ),
    );
  }

  share() {
    Share.share(widget.url);
  }
}

class KebabMenuItem extends StatefulWidget {
  final Function onTap;
  final IconData icon;
  final String text;
  const KebabMenuItem(
      {super.key, required this.onTap, required this.icon, required this.text});

  @override
  State<KebabMenuItem> createState() => _KebabMenuItemState();
}

class _KebabMenuItemState extends State<KebabMenuItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: widget.onTap(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              language[widget.text],
              style: TextStyle(fontSize: DeviceInfo().height() / 40),
            ),
            Icon(
              widget.icon,
              size: DeviceInfo().height() / 40,
              color: DeviceInfo.darkMode ? Colors.white : textGray,
            )
          ],
        ),
      ),
    );
  }
}
