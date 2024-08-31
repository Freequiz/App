import 'package:easy_localization/easy_localization.dart';
import 'package:freequiz/utilities/imports/base.dart';

class SearchBarWords extends StatefulWidget {
  final Function search;
  const SearchBarWords({super.key, required this.search});

  @override
  State<SearchBarWords> createState() => _SearchBarWordsState();
}

class _SearchBarWordsState extends State<SearchBarWords> {
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final hintColor = context.darkMode ? Colors.white : gray40;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(context.screenWidth / 100),
        color: context.darkMode ? gray55 : white235,
      ),
      width: context.screenWidth / 2,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Flexible(
              child: SizedBox(
                height: 48,
                child: TextField(
                  onChanged: (value) {
                    widget.search(textController.text);
                  },
                  keyboardAppearance:
                      context.darkMode ? Brightness.dark : Brightness.light,
                  controller: textController,
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
          ],
        ),
      ),
    );
  }
}
