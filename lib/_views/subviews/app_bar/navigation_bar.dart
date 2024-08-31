import 'package:freequiz/utilities/imports/themes.dart';
import 'package:material_symbols_icons/symbols.dart';

class TopNavigationBar extends StatelessWidget {
  final Function onPressed;
  final int index;
  const TopNavigationBar({super.key, required this.onPressed, required this.index});

  @override
  Widget build(BuildContext context) {
    Icon icon(IconData icon, bool selected) {
      return Icon(icon,
          weight: 500,
          grade: 200,
          opticalSize: 24,
          size: 20,
          color: selected
              ? Colors.white
              : context.darkMode
                  ? grayFreequiz
                  : gray70);
    }

    return Container(
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(100), border: Border.all(color: grayFreequiz, width: 3.0)),
      height: 42.0,
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      margin: const EdgeInsets.only(left: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () => onPressed(0),
            icon: icon(Symbols.home, index == 0),
          ),
          const SizedBox(width: 5.0),
          IconButton(
            onPressed: () => onPressed(1),
            icon: icon(Symbols.edit, index == 1),
          ),
          const SizedBox(width: 5.0),
          IconButton(
            onPressed: () => onPressed(2),
            icon: icon(Symbols.bug_report_rounded, index == 2),
          ),
          const SizedBox(width: 5.0),
          IconButton(
            onPressed: () => onPressed(3),
            icon: icon(Symbols.person, index == 3),
          ),
        ],
      ),
    );
  }
}
