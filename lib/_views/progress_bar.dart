import 'package:freequiz/models/color_family.dart';
import 'package:freequiz/utilities/imports/utilities.dart';

class ProgressBar extends StatefulWidget {
  final double amountLeft;
  final int amount;
  final ColorFamily color;
  const ProgressBar({super.key, required this.amountLeft, required this.amount, required this.color});

  @override
  State<ProgressBar> createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    double widthProgress = (context.screenWidth - 40) / widget.amount * (widget.amount - widget.amountLeft);
    return Container(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
      color: context.darkMode ? widget.color.dark : widget.color.light,
      child: GestureDetector(
        onTap: () {
          setState(() {
            expanded = !expanded;
          });
        },
        child: AnimatedSize(
          alignment: expanded ? Alignment.center : Alignment.topCenter,
          duration: const Duration(milliseconds: 100),
          child: Container(
            width: context.screenWidth - 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                expanded ? 10.5 : 3.5,
              ),
              color: widget.color.medium,
            ),
            height: expanded ? 21 : 7,
            alignment: Alignment.centerLeft,
            child: AnimatedSize(
              duration: const Duration(milliseconds: 100),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    expanded ? 10.5 : 3.5,
                  ),
                  color: context.darkMode ? widget.color.light : widget.color.dark,
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
      ),
    );
  }
}
