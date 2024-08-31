import 'package:freequiz/_views/_home/search_page/search.dart';
import 'package:freequiz/_views/subviews/app_bar/search_button.dart';
import 'package:freequiz/_views/subviews/app_bar/search_field.dart';
import 'package:freequiz/_views/subviews/app_bar/navigation_bar.dart';
import 'package:freequiz/loading/load_search.dart';
import 'package:freequiz/utilities/imports/utilities.dart';

class MainAppBar extends StatefulWidget implements PreferredSizeWidget {
  final FocusNode focusNode;
  final Function switchPage;
  final int indexPage;

  const MainAppBar({super.key, required this.focusNode, required this.switchPage, required this.indexPage});

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
      title: LayoutWidget(
        mobile: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Conditional(
              condition: !Search.shown,
              widget: Space.width(74.0), //Width of Search Button (64) + it's Padding (10)
            ),
            Flexible(
              child: SearchField(
                textController: textController,
                focusNode: widget.focusNode,
                dismiss: () => setState(() {
                  Search.shown = false;
                }),
              ),
            ),
            SearchButton(onPressed: onPressed)
          ],
        ),
        tablet: Row(
          children: [
            const SizedBox(width: 3.0),
            Expanded(
              child: SearchField(
                dismiss: () => setState(() {
                  Search.shown = false;
                }),
                focusNode: widget.focusNode,
                textController: textController,
              ),
            ),
            SearchButton(onPressed: onPressed),
            TopNavigationBar(onPressed: widget.switchPage, index: widget.indexPage)
          ],
        ),
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
