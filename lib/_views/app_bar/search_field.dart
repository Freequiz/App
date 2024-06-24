import 'package:easy_localization/easy_localization.dart';
import 'package:freequiz/loading/load_search.dart';
import 'package:freequiz/utilities/imports/utilities.dart';

class SearchField extends StatefulWidget {
  final FocusNode focusNode;
  final Function dismiss;
  final TextEditingController textController;

  const SearchField({super.key, required this.dismiss, required this.focusNode, required this.textController});

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  @override
  Widget build(BuildContext context) {
    final hintColor = context.darkMode ? Colors.white : gray40;

    return Flexible(
      child: SizedBox(
        height: 42.0,
        child: TextField(
          onSubmitted: (value) => loadSearch(context: context, searchTerm: widget.textController.text),
          keyboardAppearance: context.darkMode ? Brightness.dark : Brightness.light,
          controller: widget.textController,
          focusNode: widget.focusNode,
          decoration: InputDecoration(
            filled: true,
            fillColor: context.darkMode ? const Color.fromARGB(255, 45, 45, 45) : const Color.fromARGB(255, 245, 245, 245),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20.0
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(100),
              borderSide: const BorderSide(width: 3, color: grayFreequiz),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(100),
              borderSide: const BorderSide(width: 3, color: grayFreequiz),
            ),
            hintText: context.tr('search'),
            suffixIcon: IconButton(
              color: hintColor,
              onPressed: () {
                widget.textController.clear();
                widget.dismiss();
              },
              icon: const Icon(
                Icons.clear,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
