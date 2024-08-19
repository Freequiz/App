import 'package:freequiz/utilities/imports/base.dart';
import 'package:material_symbols_icons/symbols.dart';

class Dropdown extends StatefulWidget {
  final dynamic initialValue;
  final List<DropdownMenuItem<dynamic>> items;
  final Function onChanged;
  final ColorFamily color;
  final Icon? leadingIcon;
  final double? width;

  const Dropdown(
      {super.key, required this.initialValue, required this.items, required this.onChanged, required this.color, this.leadingIcon, this.width});

  @override
  State<Dropdown> createState() => _DropdownState();
}

class _DropdownState extends State<Dropdown> {
  dynamic value;

  @override
  void initState() {
    value = widget.initialValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(1000),
        color: context.darkMode ? widget.color.dark : widget.color.light,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          widget.leadingIcon ?? const SizedBox(),
          SizedBox(width: widget.leadingIcon != null ? 15 : 0),
          Flexible(
            child: DropdownButton(
              value: value,
              icon: Icon(
                Symbols.arrow_drop_down_rounded,
                color: context.darkMode ? widget.color.light : widget.color.dark,
                weight: 900,
                grade: 200,
                opticalSize: 24,
              ),
              isDense: true,
              isExpanded: true,
              menuWidth: widget.width,
              dropdownColor: context.darkMode ? widget.color.dark : widget.color.light,
              underline: const SizedBox(),
              items: widget.items,
              onChanged: (newValue) {
                setState(() {
                  value = newValue!;
                  widget.onChanged(value!);
                });
              },
              style: TextStyle(fontSize: FontSize.item, color: context.darkMode ? Colors.white : gray55, fontWeight: FontWeight.w600),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ],
      ),
    );
  }
}
