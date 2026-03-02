import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:freequiz/_views/subviews/app_bar/app_bar.dart';

class RootScreen {
  late WidgetTester tester;  

  final _appBar = find.byType(MainAppBar);
  final _profilePageButton = find.byKey(ValueKey("profilePageButton"));

  void checkForAppBar() {
    expect(_appBar, findsOneWidget);
  }

  Future<void> navigateToProfilePage() async {
    await tester.tap(_profilePageButton);
    await tester.pumpAndSettle();
  }

  RootScreen(this.tester);
}