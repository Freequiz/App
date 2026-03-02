import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

class WelcomeScreen {
  late WidgetTester tester;

  final _loginButton = find.byKey(const ValueKey('log in'));
  final _signupButton = find.byKey(const ValueKey('sign up'));

  Future<void> navigateToLogin() async {
    await tester.tap(_loginButton, warnIfMissed: true);
    await tester.pumpAndSettle();
  }

  Future<void> navigateToSignup() async {
    await tester.tap(_signupButton, warnIfMissed: true);
    await tester.pumpAndSettle();
  }

  void checkForButtons() {
    expect(_loginButton, findsOneWidget);
    expect(_signupButton, findsOneWidget);
  }
  
  WelcomeScreen(this.tester);
}