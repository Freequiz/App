import 'package:freequiz/_home/user_page/user_avatar.dart';
import 'package:freequiz/_home/user_page/user_data.dart';
import 'package:freequiz/utilities/imports/utilities.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final backgroundColor = context.darkMode ? gray55 : white235;

    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(context.screenHeight / 100),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const UserAvatar(),
          Space.width(20.0),
          Text(
            PublicUserData.name,
            style: titleStyle(),
          ),
        ],
      ),
    );
  }
}
