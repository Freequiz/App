import 'package:easy_localization/easy_localization.dart';
import 'package:freequiz/_views/badge.dart';
import 'package:freequiz/_views/buttons/share.dart';
import 'package:freequiz/loading/load_user.dart';
import 'package:freequiz/utilities/imports/utilities.dart';

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
        context.darkMode ? gray55 : white235;

    final n = widget.data["quizzes"];

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => loadUser(context: context, user: widget.data['username']),
      child: Container(
        width: context.screenWidth - 20,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(context.screenHeight/ 100),
          color: color6,
        ),
        child: Padding(
          padding: context.mobileLayout
              ? const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0, top: 5.0)
              : const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0, top: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: context.screenHeight/ 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.data['username'],
                      style: titleStyle(),
                    ),
                    ShareButton(
                      url: "https://freequiz.ch/user/${widget.data['username']}",
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 15),
                height: context.screenHeight/ 30 + 15,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InfoBadge(
                      color: roseLight,
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
