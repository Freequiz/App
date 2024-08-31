import 'package:easy_localization/easy_localization.dart';
import 'package:freequiz/_views/_home/user_page/public_quizzes.dart';
import 'package:freequiz/_views/_home/user_page/user_data.dart';
import 'package:freequiz/_views/_home/user_page/user_info.dart';
import 'package:freequiz/_views/subviews/buttons/load_more.dart';
import 'package:freequiz/services/api/users.dart';
import 'package:freequiz/utilities/imports/utilities.dart';

class UserPage extends StatefulWidget {
  final String user;
  const UserPage({super.key, required this.user});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  bool pressed = false;
  int page = 1;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.mobileLayout ? const EdgeInsets.all(10.0) : const EdgeInsets.all(20.0),
      child: ListView(
        children: [
          const UserInfo(),
          Space.height(20.0),
          Align(
            alignment: Alignment.center,
            child: Text(
              context.tr('quizzes'),
              style: titleStyle(),
            ),
          ),
          Space.height(context.mobileLayout ? 10 : 30),
          PublicQuizzes(
            user: widget.user,
          ),
          Space.height(context.mobileLayout ? 10 : 15),
          LoadMoreButton(pressed: pressed, onPressed: onPressed, more: PublicUserData.more),
        ],
      ),
    );
  }

  onPressed() async {
    setState(() {
      pressed = true;
    });
    page++;
    final data = await APIUsers.getPublicQuizzes(page, widget.user);
    PublicUserData.data.addAll(data['data']);
    PublicUserData.more = data['next_page'];
    setState(() {
      pressed = false;
    });
  }
}
