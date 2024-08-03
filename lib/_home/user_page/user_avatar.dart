import 'package:freequiz/_home/user_page/user_data.dart';
import 'package:freequiz/utilities/imports/base.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UserAvatar extends StatelessWidget {
  final String? url;
  final double size;
  const UserAvatar({super.key, this.url, this.size = 80});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: size / 2,
      backgroundColor: blueDark,
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: ClipOval(
          child: SvgPicture.network(
            url != "" ? url ?? PublicUserData.avatarURL : "http://api.dicebear.com/8.x/shapes/svg?&amp;seed=0",
            fit: BoxFit.cover,
            width: size,
            height: size,
          ),
        ),
      ),
    );
  }
}
