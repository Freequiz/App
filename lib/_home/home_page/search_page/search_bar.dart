import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:freequiz/_home/home_page/search_page/search.dart';
import 'package:freequiz/loading/load_search.dart';
import 'package:freequiz/others/style.dart';
import 'package:freequiz/utilities/extensions/context_extensions.dart';
import 'package:freequiz/utilities/widgets/space.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({super.key, required this.focusNode});

  final FocusNode focusNode;

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final hintColor = context.darkMode ? Colors.white : gray40;
    final backgroundColor = context.darkMode
        ? gray55
        : white235;
    return Container(
      width: context.mobileLayout
          ? context.screenWidth - 20
          : context.screenWidth / 2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: backgroundColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Flexible(
              child: SizedBox(
                height:
                    context.mobileLayout ? context.screenHeight/ 20 : 48,
                child: TextField(
                  onTap: () => widget.focusNode.requestFocus(),
                  onSubmitted: (value) => loadSearch(
                      context: context, searchTerm: textController.text),
                  focusNode: widget.focusNode,
                  keyboardAppearance:
                      context.darkMode ? Brightness.dark : Brightness.light,
                  controller: textController,
                  canRequestFocus: true,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: context.darkMode
                        ? const Color.fromARGB(255, 45, 45, 45)
                        : const Color.fromARGB(255, 245, 245, 245),
                    contentPadding: const EdgeInsets.all(10.0),
                    border: const OutlineInputBorder(),
                    hintText: context.tr('search'),
                    suffixIcon: IconButton(
                      color: hintColor,
                      onPressed: () {
                        textController.clear();
                      },
                      icon: const Icon(
                        Icons.clear,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Space.width(5),
            SizedBox(
              height: context.mobileLayout ? context.screenHeight/ 20 : 48,
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: grayFreequiz,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  Search.mode == "Quiz";
                  loadSearch(context: context, searchTerm: textController.text);
                },
                child: const Icon(Icons.search_rounded),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
