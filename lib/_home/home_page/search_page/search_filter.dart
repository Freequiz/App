import 'package:flutter/material.dart';
import 'package:freequiz/others/device_info.dart';

class SearchFilter extends StatelessWidget {
  final Color color;
  final Widget child;
  const SearchFilter({super.key, required this.color, required this.child});

  @override
  Widget build(BuildContext context) {
    final color6 = DeviceInfo.darkMode
        ? const Color.fromARGB(255, 55, 55, 55)
        : color;
    return Container(
      decoration: BoxDecoration(
          color: color6,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: color, width: 2.0)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Center(
          child: child,
        ),
      ),
    );
  }
}
