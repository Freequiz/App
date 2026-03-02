import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

class ProfileScreen {
  late WidgetTester tester;  

  final _deleteAccountButton = find.byKey(ValueKey('deleteAccountButton'));

  Future<void> deleteAccount() async {
    await tester.tap(_deleteAccountButton);
    await tester.pumpAndSettle();
  }

  ProfileScreen(this.tester);
}