import 'package:freequiz/_views/profile/profile_page/confirmation.dart';
import 'package:freequiz/_views/profile/profile_page/dark_mode_switcher.dart';
import 'package:freequiz/_views/profile/profile_page/email.dart';
import 'package:freequiz/_views/profile/profile_page/password.dart';
import 'package:freequiz/_views/profile/profile_page/username.dart';
import 'package:freequiz/controllers/profile/profile.dart';
import 'package:freequiz/_views/subviews/buttons/long_button.dart';
import 'package:freequiz/_views/subviews/category_title.dart';
import 'package:freequiz/controllers/profile/profile_page.dart';
import 'package:freequiz/controllers/profile/user.dart';
import 'package:freequiz/services/api/users.dart';
import 'package:freequiz/utilities/imports/utilities.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  final Function refresh;
  const ProfilePage({super.key, required this.refresh});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    Provider.of<ProfilePageController>(context);
    UserHelper.load();

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal:
                  context.mobileLayout ? 10.0 : context.screenWidth / 5.5),
          child: ListView(
            children: [
              SizedBox(height: context.screenHeight / 60),
              CategoryTitle(
                  icon: Symbols.dark_mode_rounded,
                  color: rose,
                  title: 'appearance'),
              const DarkModeSwitcher(),
              SizedBox(height: context.screenHeight / 60),
              CategoryTitle(
                  icon: Symbols.person, color: purple, title: 'account'),
              Username(),
              const SizedBox(height: 10.0),
              EMail(),
              const SizedBox(height: 10.0),
              Password(),
              const SizedBox(height: 10.0),
              Row(
                children: [
                  LongButton(
                    key: ValueKey('deleteAccountButton'),
                    onPressed: () async {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) =>
                            Confirmation(refresh: widget.refresh),
                      );
                    },
                    text: 'delete account',
                    color: context.darkMode ? redDark : redMedium,
                  ),
                  const SizedBox(
                    width: 15.0,
                  ),
                  LongButton(
                    onPressed: () async {
                      APIUsers.logout();
                      Profile.deleteData();
                      widget.refresh();
                    },
                    text: 'logout',
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
