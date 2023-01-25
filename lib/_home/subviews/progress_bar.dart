import 'package:flutter/material.dart';
import 'package:freequiz/others/device_info.dart';

class ProgressBar extends StatefulWidget {
  final int amountLeft;
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
    final color5 = DeviceInfo.darkMode
        ? const Color.fromARGB(255, 60, 60, 60)
        : const Color.fromARGB(255, 225, 225, 225);
    double widthProgress =
        DeviceInfo().width() / widget.amount * (widget.amount - widget.amountLeft);
    return GestureDetector(
      onTap: () {
        setState(() {
          expanded = !expanded;
        });
      },
      child: AnimatedSize(
        duration: const Duration(milliseconds: 100),
        child: Container(
          width: DeviceInfo().width(),
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
              height: expanded ? 21 : 7,
              alignment: Alignment.centerRight,
              child: widthProgress > 25
                  ? expanded
                      ? Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 3.0,
                          ),
                          child: Text(
                              "${(100 / widget.amount * (widget.amount - widget.amountLeft)).round()}%"),
                        )
                      : const SizedBox()
                  : const SizedBox(),
            ),
          ),
        ),
      ),
    );
  }
}
