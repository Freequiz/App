import 'package:easy_localization/easy_localization.dart';
import 'package:freequiz/controllers/_home/search.dart';
import 'package:freequiz/_views/edit/edit_create_quiz/subviews/dropdown.dart';
import 'package:freequiz/controllers/others/languages.dart';
import 'package:freequiz/utilities/imports/utilities.dart';


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
    return AlertDialog(
      title: Text(
        context.tr('language'),
        style: TextStyle(color: context.darkMode ? Colors.white : Colors.black),
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
            Flexible(
              child: Dropdown(
                initialValue: from,
                items: languages,
                onChanged: (value) {
                  setState(() {
                    from = value!;
                  });
                },
                color: rose,
              ),
            ),
            const SizedBox(width: 10),
            const Icon(
              Icons.arrow_forward_rounded,
              color: roseMiddle,
            ),
            const SizedBox(width: 10),
            Flexible(
              child: Dropdown(
                initialValue: to,
                items: languages,
                onChanged: (value) {
                  setState(() {
                    to = value!;
                  });
                },
                color: rose,
              ),
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
