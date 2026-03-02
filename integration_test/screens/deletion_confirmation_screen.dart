import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

class DeletionConfirmationScreen {
  late WidgetTester tester;  

  final _confirmDeletionButton = find.byKey(ValueKey('confirmDeletionButton'));

  Future<void> deleteAccount() async {
    await tester.tap(_confirmDeletionButton);
    await tester.pump(const Duration(seconds: 2));
  }

  DeletionConfirmationScreen(this.tester);
}