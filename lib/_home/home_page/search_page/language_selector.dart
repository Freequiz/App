import 'package:flutter/material.dart';
import 'package:freequiz/_home/home_page/search_page/search.dart';
import 'package:freequiz/others/device_info.dart';
import 'package:freequiz/others/initial_loading.dart';
import 'package:freequiz/others/languages.dart';
import 'package:freequiz/others/string_extensions.dart';
import 'package:freequiz/others/style.dart';
import 'package:freequiz/others/utilities.dart';

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
    final hintColor =
        DeviceInfo.darkMode ? Colors.white : const Color.fromARGB(255, 40, 40, 40);
    return AlertDialog(
      title: Text(
        "Language".transl(),
        style: TextStyle(color: DeviceInfo.darkMode ? Colors.white : Colors.black),
      ),
      content: Text(
        "Choose the desired languages".transl(),
      ),
      actionsAlignment: MainAxisAlignment.spaceAround,
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            DropdownButton(
              value: from,
              icon: const Icon(
                Icons.arrow_drop_down_rounded,
                color: color1,
              ),
              underline: Container(
                height: 2,
                color: color1,
              ),
              dropdownColor: DeviceInfo.darkMode
                  ? const Color.fromARGB(255, 40, 40, 40)
                  : const Color.fromARGB(255, 229, 242, 250),
              items: languages,
              onChanged: (value) {
                setState(() {
                  from = value!;
                });
              },
              style: textColor(hintColor),
            ),
            const Icon(
              Icons.arrow_forward_rounded,
              color: color1,
            ),
            DropdownButton(
              value: to,
              icon: const Icon(
                Icons.arrow_drop_down_rounded,
                color: color1,
              ),
              underline: Container(
                height: 2,
                color: color1,
              ),
              dropdownColor: DeviceInfo.darkMode
                  ? const Color.fromARGB(255, 40, 40, 40)
                  : const Color.fromARGB(255, 229, 242, 250),
              items: languages,
              onChanged: (value) {
                setState(() {
                  to = value!;
                });
              },
              style: textColor(hintColor),
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
