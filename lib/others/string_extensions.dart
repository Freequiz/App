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

extension Truncate on String {
  String truncate(int amount) {
    final String trimmedString = characters.take(amount).toString();
    if (trimmedString.length == length) {
      return trimmedString;
    }
    return '$trimmedString...';
  }
}

extension Format on String {
  String format() {
    return trim()
            .replaceAll(',', ' ')
            .replaceAll('/', ' ')
            .replaceAll('', ' ')
            .replaceAll('.', ' ')
            .replaceAll(';', ' ')
            .replaceAll('(', ' ')
            .replaceAll(')', ' ')
            .replaceAll('.', ' ')
            .replaceAll('\u2019', '\u0027')
            .replaceAll('\u2018', '\u0027')
            .replaceAll('   ', '')
            .replaceAll('  ', '');
  }
}
