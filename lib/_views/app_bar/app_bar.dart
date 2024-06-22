import 'package:freequiz/_home/search_page/search.dart';
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
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _MainAppBarState extends State<MainAppBar> {
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Search.shown
          ? SearchField(
              focusNode: widget.focusNode,
              dismiss: () => setState(() {
                Search.shown = false;
              }),
            )
          : const AppBarTitle(),
      actions: [
        TextButton(
          style: TextButton.styleFrom(
            backgroundColor: grayFreequiz,
            foregroundColor: Colors.white,
          ),
          onPressed: () => onPressed(),
          child: const Icon(Icons.search_rounded),
        ),
      ],
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
        // ignore: use_build_context_synchronously
        FocusScope.of(context).requestFocus(widget.focusNode);
      }
    });
  }
}
