import 'package:characters/characters.dart';

extension Capitalizing on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
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
