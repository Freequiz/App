import 'package:freequiz/utilities/imports/base.dart';
import 'package:freequiz/utilities/widgets/conditional.dart';
import 'package:material_symbols_icons/symbols.dart';

class ExpandButton extends StatefulWidget {
  final bool shown;
  final Function onPressed;
  const ExpandButton({super.key, required this.shown, required this.onPressed});

  @override
  State<ExpandButton> createState() => _ExpandButtonState();
}

class _ExpandButtonState extends State<ExpandButton> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    return Conditional(
      condition: widget.shown,
      widget: IconButton(
        onPressed: () {
          setState(() {
            expanded = !expanded;
          });
          widget.onPressed();
        },
        color: grayFreequiz,
        icon: Icon(
          expanded ? Symbols.unfold_less : Symbols.unfold_more,
          weight: 700,
          grade: 200,
        ),
      ),
    );
  }
}
