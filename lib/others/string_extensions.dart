import 'package:characters/characters.dart';
import 'package:freequiz/others/initial_loading.dart';

extension Capitalizing on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

extension Translating on String {
  String transl() {
    return language[this] ?? this;
  }
}

extension Triming on String {
  String triming(int amount) {
    final String trimmedDescription = characters.take(amount).toString();
    if (trimmedDescription.length == length) {
      return trimmedDescription;
    }
    return '$trimmedDescription...';
  }
}
