import 'package:flutter/material.dart';

class Conditional extends StatelessWidget {

  final bool condition;
  final Widget widget;
  final Widget defaultWidget;

  const Conditional({super.key, required this.condition, required this.widget, this.defaultWidget = const SizedBox()});

  @override
  Widget build(BuildContext context) {
    if (condition) return widget;
    return defaultWidget;
  }
}