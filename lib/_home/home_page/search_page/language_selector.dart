import 'package:flutter/material.dart';
import 'package:freequiz/_home/home_page/search_page/search.dart';
import 'package:freequiz/others/initial_loading.dart';
import 'package:freequiz/others/style.dart';

class LanguageSelector extends StatefulWidget {
  final Function refresh;
  const LanguageSelector({super.key, required this.refresh});

  @override
  State<LanguageSelector> createState() => _LanguageSelectorState();
}

class _LanguageSelectorState extends State<LanguageSelector> {
  final List<DropdownMenuItem<String>> languages = [
    DropdownMenuItem(
      value: "Any",
      child: Text(language["Any"]),
    ),
    DropdownMenuItem(
      value: "German",
      child: Text(language["German"]),
    ),
    DropdownMenuItem(
      value: "English",
      child: Text(language["English"]),
    ),
    DropdownMenuItem(
      value: "French",
      child: Text(language["French"]),
    ),
    DropdownMenuItem(
      value: "Italian",
      child: Text(language["Italian"]),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final brightness = MediaQuery.of(context).platformBrightness;
    bool darkMode = brightness == Brightness.dark;
    final hintColor =
        darkMode ? Colors.white : const Color.fromARGB(255, 40, 40, 40);
    return AlertDialog(
      title: Text(
        language["Language"],
        style: TextStyle(color: darkMode ? Colors.white : Colors.black),
      ),
      content: Text(
        language["Choose the desired languages"],
      ),
      actionsAlignment: MainAxisAlignment.spaceAround,
      actions: [
        DropdownButton(
          value: Search.from,
          icon: Icon(
            Icons.arrow_drop_down_rounded,
            color: color1,
          ),
          underline: Container(
            height: 2,
            color: color1,
          ),
          dropdownColor: darkMode
              ? const Color.fromARGB(255, 40, 40, 40)
              : const Color.fromARGB(255, 229, 242, 250),
          items: languages,
          onChanged: (value) {
            widget.refresh();
            setState(() {
              Search.from = value!;
            });
          },
          style: TextStyle(color: hintColor),
        ),
        Icon(
          Icons.arrow_forward_rounded,
          color: color1,
        ),
        DropdownButton(
          value: Search.to,
          icon: Icon(
            Icons.arrow_drop_down_rounded,
            color: color1,
          ),
          underline: Container(
            height: 2,
            color: color1,
          ),
          dropdownColor: darkMode
              ? const Color.fromARGB(255, 40, 40, 40)
              : const Color.fromARGB(255, 229, 242, 250),
          items: languages,
          onChanged: (value) {
            widget.refresh();
            setState(() {
              Search.to = value!;
            });
          },
          style: TextStyle(color: hintColor),
        ),
      ],
    );
  }
}
