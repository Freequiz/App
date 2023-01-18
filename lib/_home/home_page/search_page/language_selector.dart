import 'package:flutter/material.dart';
import 'package:freequiz/_home/home_page/search_page/search.dart';
import 'package:freequiz/others/initial_loading.dart';
import 'package:freequiz/others/languages.dart';
import 'package:freequiz/others/style.dart';

class LanguageSelector extends StatefulWidget {
  final Function refresh;
  const LanguageSelector({super.key, required this.refresh});

  @override
  State<LanguageSelector> createState() => _LanguageSelectorState();
}

class _LanguageSelectorState extends State<LanguageSelector> {
  final List<DropdownMenuItem<int>> languages = List.from(Languages.languages);

  int from = 0;
  int to = 0;

  @override
  void initState() {
    from = Languages().nameToId(Search.from);
    to = Languages().nameToId(Search.to);
    languages.add(
      DropdownMenuItem(
        value: 0,
        child: Text(language["Any"]),
      ),
    );
    super.initState();
  }

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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            DropdownButton(
              value: from,
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
                setState(() {
                  from = value!;
                });
              },
              style: TextStyle(color: hintColor),
            ),
            Icon(
              Icons.arrow_forward_rounded,
              color: color1,
            ),
            DropdownButton(
              value: to,
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
                setState(() {
                  to = value!;
                });
              },
              style: TextStyle(color: hintColor),
            ),
          ],
        ),
        TextButton(
          onPressed: () {
            Search.to = Languages().idToName(to);
            Search.from = Languages().idToName(from);
            Navigator.of(context).pop();
            widget.refresh();
          },
          child: Text(
            language["Done"],
          ),
        ),
      ],
    );
  }
}
