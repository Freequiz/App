import 'package:flutter_test/flutter_test.dart';
import 'package:freequiz/_views/subviews/buttons/submit.dart';
import 'package:freequiz/_views/subviews/textfields/password.dart';
import 'package:freequiz/_views/subviews/textfields/username.dart';

class LoginScreen {
  late WidgetTester tester;  

  final _usernameField = find.byType(UsernameTextfield);
  final _passwordField = find.byType(PasswordTextfield);

  final _submitButton = find.byType(SubmitButton);

  Future<void> inputUsername() async {
    await tester.enterText(_usernameField, "App_Tests");
    await tester.pump();
  }

  Future<void> inputPassword() async {
    await tester.enterText(_passwordField, "AppTests0");
    await tester.pump();
  }

  Future <void> submit() async {
    await tester.tap(_submitButton);
    await tester.pumpAndSettle();
  }
  
  LoginScreen(this.tester);
}