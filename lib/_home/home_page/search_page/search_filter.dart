import 'package:flutter/material.dart';
import 'package:freequiz/others/device_info.dart';

class SearchFilter extends StatefulWidget {
  final Color color;
  final Widget child;
  const SearchFilter({super.key, required this.color, required this.child});

  @override
  State<SearchFilter> createState() => _SearchFilterState();
}

class _SearchFilterState extends State<SearchFilter> {
  @override
  Widget build(BuildContext context) {
    final color6 = DeviceInfo.darkMode
        ? const Color.fromARGB(255, 55, 55, 55)
        : widget.color;
    return Container(
      decoration: BoxDecoration(
          color: color6,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: widget.color, width: 2.0)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Center(
          child: widget.child,
        ),
      ),
    );
  }
}
