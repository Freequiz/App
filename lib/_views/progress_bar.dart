import 'package:flutter/material.dart';
import 'package:freequiz/others/style.dart';
import 'package:freequiz/utilities/extensions/context_extensions.dart';
import 'package:freequiz/utilities/widgets/conditional.dart';

class ProgressBar extends StatefulWidget {
  final double amountLeft;
  final int amount;
  const ProgressBar(
      {super.key, required this.amountLeft, required this.amount});

  @override
  State<ProgressBar> createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    final color5 = context.darkMode
        ? gray60
        : white225;
    double widthProgress = context.screenWidth /
        widget.amount *
        (widget.amount - widget.amountLeft);
    return GestureDetector(
      onTap: () {
        setState(() {
          expanded = !expanded;
        });
      },
      child: AnimatedSize(
        alignment: expanded ? Alignment.center : Alignment.topCenter,
        duration: const Duration(milliseconds: 100),
        child: Container(
          width: context.screenWidth,
          height: expanded ? 21 : 7,
          color: color5,
          alignment: Alignment.centerLeft,
          child: AnimatedSize(
            duration: const Duration(milliseconds: 100),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomRight: expanded
                        ? const Radius.circular(10.5)
                        : const Radius.circular(3.5),
                    topRight: expanded
                        ? const Radius.circular(10.5)
                        : const Radius.circular(3.5)),
                color: Colors.green,
              ),
              width: widthProgress,
              alignment: Alignment.centerRight,
              child: Conditional(
                condition: widthProgress > 35,
                widget: Conditional(
                  condition: expanded,
                  widget: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 3.0,
                    ),
                    child: Text(
                      widget.amount == 0
                          ? "0%"
                          : "${(100 / widget.amount * (widget.amount - widget.amountLeft)).round()}%",
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
