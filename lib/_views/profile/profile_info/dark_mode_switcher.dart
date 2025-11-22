import 'package:freequiz/_views/subviews/switcher/switcher.dart';
import 'package:freequiz/services/local_storage/preferences.dart';
import 'package:freequiz/utilities/imports/utilities.dart';
import 'package:freequiz/utilities/providers/theme.dart';
import 'package:provider/provider.dart';

class DarkModeSwitcher extends StatefulWidget {
  const DarkModeSwitcher({super.key});

  @override
  State<DarkModeSwitcher> createState() => _DarkModeSwitcherState();
}

class _DarkModeSwitcherState extends State<DarkModeSwitcher> {
  @override
  Widget build(BuildContext context) {
    return Switcher(
      onTap: onTap,
      texts: const ["Dark Mode", "Automatic", "Light Mode"],
      value: Preferences.theme,
      width: context.mobileLayout ? context.screenWidth - 20 : context.screenWidth / 5.5 * 3.5,
    );
  }

  void onTap(String value) {
    setState(() {
      Preferences.theme = value;
    });
    Provider.of<ThemeProvider>(context, listen: false).toggleTheme(value);
  }
}
