import 'package:easy_localization/easy_localization.dart';
import 'package:freequiz/_home/user_page/public_quizzes.dart';
import 'package:freequiz/_home/user_page/user_data.dart';
import 'package:freequiz/_home/user_page/user_info.dart';
import 'package:freequiz/api/users.dart';
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
              style: TextStyle(fontSize: context.screenHeight / 30),
            ),
          ),
          Space.height(context.mobileLayout ? 10 : 30),
          PublicQuizzes(
            user: widget.user,
          ),
          Space.height(context.mobileLayout ? 5 : 15),
          Conditional(
            condition: pressed,
            widget: Align(
              child: CircularProgressIndicator(
                color: context.darkMode ? Colors.white : grayFreequiz,
              ),
            ),
            defaultWidget: Align(
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: grayFreequiz,
                  foregroundColor: Colors.white,
                ),
                onPressed: () => onPressed(),
                child: Text(
                  context.tr('load more'),
                  style: TextStyle(color: Colors.white, fontSize: context.screenHeight / 55),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  onPressed() async {
    setState(() {
      pressed = true;
    });
    page++;
    PublicUserData.data.addAll(
      (await APIUsers.getPublicQuizzes(page, widget.user))['data'],
    );
    setState(() {
      pressed = false;
    });
  }
}
