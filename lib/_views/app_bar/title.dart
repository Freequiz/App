import 'package:freequiz/utilities/imports/base.dart';

class AppBarTitle extends StatelessWidget {
  const AppBarTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      "Freequiz",
      style: TextStyle(
        fontWeight: FontWeight.w900,
        fontSize: FontSize.headline,
      ),
    );
  }
}
