import 'package:easy_localization/easy_localization.dart';
import 'package:freequiz/utilities/imports/utilities.dart';
import 'package:material_symbols_icons/symbols.dart';

class WordListTaskbar extends StatefulWidget {
  final Function search;
  const WordListTaskbar({super.key, required this.search});

  @override
  State<WordListTaskbar> createState() => _WordListTaskbarState();
}

class _WordListTaskbarState extends State<WordListTaskbar> {
  final textController = TextEditingController();
  bool search = false;

  @override
  Widget build(BuildContext context) {
    final hintColor = context.darkMode ? Colors.white : gray40;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: search ? 5 : 13),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(13),
          topRight: Radius.circular(13),
          bottomLeft: Radius.circular(13),
          bottomRight: Radius.circular(13),
        ),
        color: context.darkMode ? darkMainColor : lightMainColor,
      ),
      child: Conditional(
        condition: search,
        widget: TextField(
          onChanged: (value) {
            widget.search(textController.text);
          },
          controller: textController,
          decoration: InputDecoration(
            filled: true,
            fillColor:
                context.darkMode ? const Color.fromARGB(255, 45, 45, 45) : const Color.fromARGB(255, 245, 245, 245),
            contentPadding: const EdgeInsets.all(10.0),
            border: OutlineInputBorder(
              borderSide: const BorderSide(
                color: roseLight,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(7),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: grayFreequiz,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(7),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: blueLight,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(7),
            ),
            hintText: context.tr('search'),
            suffixIcon: IconButton(
              color: hintColor,
              onPressed: () {
                textController.clear();
                setState(() {
                  widget.search("");
                  search = !search;
                });
              },
              icon: const Icon(
                Icons.clear,
              ),
            ),
          ),
        ),
        defaultWidget: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  context.tr('definition'),
                  style: titleStyle(),
                ),
              ),
            ),
            Flexible(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  context.tr('answer'),
                  style: titleStyle(),
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  search = !search;
                });
              },
              icon: const Icon(
                Symbols.search,
                weight: 700,
                grade: 200,
                opticalSize: 24,
                size: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
