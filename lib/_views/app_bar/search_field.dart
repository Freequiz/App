import 'package:easy_localization/easy_localization.dart';
import 'package:freequiz/loading/load_search.dart';
import 'package:freequiz/utilities/imports/utilities.dart';

class SearchField extends StatefulWidget {
  final FocusNode focusNode;
  final Function dismiss;

  const SearchField({super.key, required this.dismiss, required this.focusNode});

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final hintColor = context.darkMode ? Colors.white : gray40;

    return TextField(
      onSubmitted: (value) => loadSearch(context: context, searchTerm: textController.text),
      keyboardAppearance: context.darkMode ? Brightness.dark : Brightness.light,
      controller: textController,
      focusNode: widget.focusNode,
      decoration: InputDecoration(
        filled: true,
        fillColor: context.darkMode ? const Color.fromARGB(255, 45, 45, 45) : const Color.fromARGB(255, 245, 245, 245),
        contentPadding: const EdgeInsets.all(10.0),
        border: const OutlineInputBorder(),
        hintText: context.tr('search'),
        suffixIcon: IconButton(
          color: hintColor,
          onPressed: () {
            textController.clear();
            widget.dismiss();
          },
          icon: const Icon(
            Icons.clear,
          ),
        ),
      ),
    );
  }
}
