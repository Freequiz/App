import 'package:freequiz/_home/search_page/search.dart';
import 'package:freequiz/_views/app_bar/search_button.dart';
import 'package:freequiz/_views/app_bar/search_field.dart';
import 'package:freequiz/_views/app_bar/title.dart';
import 'package:freequiz/loading/load_search.dart';
import 'package:freequiz/utilities/imports/utilities.dart';

class MainAppBar extends StatefulWidget implements PreferredSizeWidget {
  final FocusNode focusNode;

  const MainAppBar({super.key, required this.focusNode});

  @override
  State<MainAppBar> createState() => _MainAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 5);
}

class _MainAppBarState extends State<MainAppBar> {
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Conditional(
            condition: !Search.shown,
            widget: Space.width(74.0), //Width of Search Button (64) + it's Padding (10)
          ),
          Conditional(
            condition: Search.shown,
            widget: SearchField(
              textController: textController,
              focusNode: widget.focusNode,
              dismiss: () => setState(() {
                Search.shown = false;
              }),
            ),
            defaultWidget: const AppBarTitle(),
          ),
          SearchButton(onPressed: onPressed)
        ],
      ),
    );
  }

  onPressed() {
    if (Search.shown) {
      Search.mode == "Quiz";
      loadSearch(context: context, searchTerm: textController.text);
      return;
    }
    Search.shown = true;
    setState(() {});
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) {
        FocusScope.of(context).requestFocus(widget.focusNode);
      }
    });
  }
}
