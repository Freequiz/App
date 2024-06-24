import 'package:freequiz/_views/switcher/switcher.dart';
import 'package:freequiz/utilities/imports/base.dart';

class SearchSwitcher extends StatelessWidget {
  final Function onTap;
  final List<String> options;
  const SearchSwitcher({super.key, required this.onTap, required this.options});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: context.darkMode ? darkMainColor : lightMainColor,
      padding: const EdgeInsets.only(
        left: 40,
        right: 40,
        top: 10,
        bottom: 20,
      ),
      child: Switcher(
        onTap: onTap,
        texts: options,
        value: 'Quiz',
        height: 42,
        highlightedColor: context.darkMode ? grayFreequiz : const Color.fromARGB(255, 208, 168, 179),
        color: context.darkMode ? null : const Color.fromARGB(255, 247, 225, 231),
        width: context.screenWidth - 80,
      ),
    );
  }
}
