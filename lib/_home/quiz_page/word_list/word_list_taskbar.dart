import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:freequiz/others/style.dart';
import 'package:freequiz/utilities/extensions/context_extensions.dart';
import 'package:freequiz/utilities/widgets/conditional.dart';

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
      height: context.screenHeight/ 18,
      padding: EdgeInsets.all(context.mobileLayout ? 0 : context.screenHeight/ 80),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(context.screenWidth / 30.4),
          topRight: Radius.circular(context.screenWidth / 30.4),
        ),
        color: grayFreequiz,
      ),
      child: Conditional(
        condition: search,
        widget: Padding(
          padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 3.0),
          child: TextField(
            onChanged: (value) {
              widget.search(textController.text);
            },
            keyboardAppearance: context.darkMode ? Brightness.dark : Brightness.light,
            controller: textController,
            decoration: InputDecoration(
              filled: true,
              fillColor: context.darkMode
                  ? const Color.fromARGB(255, 45, 45, 45)
                  : const Color.fromARGB(255, 245, 245, 245),
              contentPadding: const EdgeInsets.all(10.0),
              border: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: roseFreequiz,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(50.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: grayFreequiz,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(context.screenWidth / 30.4),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: blueFreequiz,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(context.screenWidth / 30.4),
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
        ),
        defaultWidget: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(width: 5.0),
            Container(
              width: context.mobileLayout
                  ? (context.screenWidth - 30) / 2 - context.screenHeight/ 30
                  : (context.screenWidth - 30) / 2 - context.screenHeight/ 20 - context.screenHeight/ 80,
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(
                  context.tr('definition'),
                  style: TextStyle(
                      fontSize: context.mobileLayout ? context.screenHeight/ 50 : context.screenHeight/ 45,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
              ),
            ),
            Container(
              width: context.mobileLayout
                  ? (context.screenWidth - 30) / 2 - context.screenHeight/ 30
                  : (context.screenWidth - 30) / 2 - context.screenHeight/ 20 - context.screenHeight/ 80,
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(
                  context.tr('answer'),
                  style: TextStyle(
                      fontSize: context.mobileLayout ? context.screenHeight/ 50 : context.screenHeight/ 45,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              width: context.screenHeight/ 20,
              child: TextButton(
                onPressed: () {
                  setState(() {
                    search = !search;
                  });
                },
                child: Icon(
                  Icons.search,
                  color: Colors.white,
                  size: context.mobileLayout ? context.screenHeight/ 50 : context.screenHeight/ 45,
                ),
              ),
            ),
            const SizedBox(width: 5.0),
          ],
        ),
      ),
    );
  }
}
