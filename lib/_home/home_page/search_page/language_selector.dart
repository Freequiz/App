import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:freequiz/_home/home_page/search_page/search.dart';
import 'package:freequiz/_views/edit/dropdown.dart';
import 'package:freequiz/others/device_info.dart';
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
        child: const Text('any').tr(),
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final hintColor = DeviceInfo.darkMode ? Colors.white : const Color.fromARGB(255, 40, 40, 40);

    return AlertDialog(
      title: Text(
        context.tr('language'),
        style: TextStyle(color: DeviceInfo.darkMode ? Colors.white : Colors.black),
      ),
      insetPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
      content: Text(
        context.tr('choose language'),
      ),
      actionsAlignment: MainAxisAlignment.spaceAround,
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Dropdown(
              initialValue: from,
              items: languages,
              onChanged: (value) {
                setState(() {
                  from = value!;
                });
              },
              hintColor: hintColor,
            ),
            const Icon(
              Icons.arrow_forward_rounded,
              color: grayFreequiz,
            ),
            Dropdown(
              initialValue: to,
              items: languages,
              onChanged: (value) {
                setState(() {
                  to = value!;
                });
              },
              hintColor: hintColor,
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
            context.tr('done'),
          ),
        ),
      ],
    );
  }
}
