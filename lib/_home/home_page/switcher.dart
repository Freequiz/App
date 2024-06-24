import 'package:freequiz/_views/switcher/switcher.dart';
import 'package:freequiz/utilities/imports/base.dart';

class HomePageSwitcher extends StatelessWidget {
  final Function onTap;
  final List<String> options;
  const HomePageSwitcher({super.key, required this.onTap, required this.options});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: context.darkMode ? darkMainColor : lightMainColor,
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
        top: 10,
        bottom: 20,
      ),
      child: Switcher(
        onTap: onTap,
        texts: options,
        value: 'history',
        height: 42,
        highlightedColor: context.darkMode ? grayFreequiz : const Color.fromARGB(255, 208, 168, 179),
        color: context.darkMode ? null : const Color.fromARGB(255, 247, 225, 231),
        width: context.screenWidth - 40,
        icons: [
          Icon(
            Icons.history,
            size: 28,
            color: context.darkMode ? null : gray70,
          ),
          Icon(
            Icons.star_rounded,
            size: 28,
            color: context.darkMode ? null : gray70,
          ),
          Icon(
            Icons.person,
            size: 28,
            color: context.darkMode ? null : gray70,
          ),
        ],
      ),
    );
  }
}
