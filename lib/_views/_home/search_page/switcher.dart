import 'package:freequiz/_views/subviews/switcher/switcher.dart';
import 'package:freequiz/controllers/_home/search.dart';
import 'package:freequiz/utilities/imports/base.dart';
import 'package:provider/provider.dart';

class SearchSwitcher extends StatelessWidget {
  const SearchSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<Search>(context);

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
        onTap: controller.onTap,
        texts: controller.options,
        value: 'Quiz',
        height: 42,
        highlightedColor: context.darkMode ? grayFreequiz : const Color.fromARGB(255, 208, 168, 179),
        color: context.darkMode ? null : const Color.fromARGB(255, 247, 225, 231),
        width: context.screenWidth - 80,
      ),
    );
  }
}
