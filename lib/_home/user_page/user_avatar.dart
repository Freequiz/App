import 'package:freequiz/_home/user_page/user_data.dart';
import 'package:freequiz/utilities/imports/base.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 40,
      backgroundColor: blueDark,
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: ClipOval(
          child: SvgPicture.network(
            PublicUserData.avatarURL,
            fit: BoxFit.cover,
            width: 80,
            height: 80,
          ),
        ),
      ),
    );
  }
}
