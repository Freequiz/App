import 'package:freequiz/utilities/imports/base.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class SearchButton extends StatelessWidget {
  final Function onPressed;

  const SearchButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42.0,
      width: 64.0,
      margin: const EdgeInsets.only(left: 10.0),
      child: TextButton(
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
          side: const BorderSide(color: grayFreequiz, width: 3.0),
        ),
        onPressed: () => onPressed(),
        child: const Icon(
          Symbols.search_rounded,
          weight: 700,
          grade: 200,
          opticalSize: 24,
          size: 24,
        ),
      ),
    );
  }
}
