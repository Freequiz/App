import 'package:flutter_animate/flutter_animate.dart';
import 'package:freequiz/_views/subviews/switcher/button.dart';
import 'package:freequiz/utilities/imports/base.dart';

class Switcher extends StatefulWidget {
  const Switcher(
      {super.key, required this.onTap, required this.texts, required this.value, required this.width, this.icons, this.height = 50, this.color, this.highlightedColor});

  final Function onTap;
  final List<String> texts;
  final String value;
  final List<Icon>? icons;
  final double width;
  final double height;
  final Color? highlightedColor;
  final Color? color;

  @override
  State<Switcher> createState() => _SwitcherState();
}

class _SwitcherState extends State<Switcher> {
  String previousValue = "";
  String value = "";

  bool deactivated = false;
  bool onChange = false;

  @override
  void initState() {
    previousValue = widget.value;
    value = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: widget.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(context.screenHeight / 100),
        color: widget.color ?? (context.darkMode ? gray55 : white235),
      ),
      child: Stack(
        children: [
          Container(
            width: widget.width / widget.texts.length,
            height: widget.height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(context.screenHeight / 100),
              color: widget.highlightedColor ?? (context.darkMode ? gray70 : white205),
            ),
          )
              .animate(target: onChange ? 1 : 0)
              .moveX(
                begin: widget.texts.indexOf(previousValue) * widget.width / widget.texts.length,
                end: widget.texts.indexOf(value) * widget.width / widget.texts.length,
                duration: const Duration(milliseconds: 200),
              )
              .callback(
            callback: (_) {
              setState(() {
                previousValue = value; 
                onChange = false;
              });
              Future.delayed(const Duration(milliseconds: 200), (){
                deactivated = false;
              });
            },
          ),
          Row(
            children: children(),
          ),
        ],
      ),
    );
  }

  List<Widget> children() {
    final List<Widget> children = [];
    for (int i = 0; i < widget.texts.length; i++) {
      children.add(
        SwitcherButton(
          onTap: onTap,
          text: widget.texts[i],
          icon: widget.icons?[i],
          selected: widget.texts[i] == value,
        ),
      );
    }
    return children;
  }

  onTap(String text) {
    if (deactivated) return; //prevent breaking animation by clicking the buttons too fast

    setState(() {
      value = text;
      onChange = true;
    });

    widget.onTap(text);
    deactivated = true;
  }
}
