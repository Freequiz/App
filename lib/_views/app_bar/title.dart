import 'package:freequiz/utilities/imports/base.dart';

class AppBarTitle extends StatelessWidget {
  const AppBarTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      "Freequiz",
      style: TextStyle(
        fontWeight: FontWeight.w900,
        fontSize: FontSize.headline,
        color: context.darkMode ? Colors.white : gray40
      ),
    );
  }
}
