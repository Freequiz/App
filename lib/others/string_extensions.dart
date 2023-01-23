import 'package:freequiz/others/initial_loading.dart';

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
  String transl() {
    return language[this] ?? this;
  }
}