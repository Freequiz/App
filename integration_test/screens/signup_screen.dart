import 'package:flutter_test/flutter_test.dart';
import 'package:freequiz/_views/subviews/buttons/submit.dart';
import 'package:freequiz/_views/subviews/textfields/email.dart';
import 'package:freequiz/_views/subviews/textfields/password.dart';
import 'package:freequiz/_views/subviews/textfields/password_confirmation.dart';
import 'package:freequiz/_views/subviews/textfields/username.dart';

class SignupScreen {
  late WidgetTester tester;  

  final _usernameField = find.byType(UsernameTextfield);
  final _emailField = find.byType(EmailTextfield);
  final _passwordField = find.byType(PasswordTextfield);
  final _passwordConfirmationField = find.byType(PasswordConfirmationTextfield);

  final _submitButton = find.byType(SubmitButton);

  Future<void> inputUsername() async {
    await tester.enterText(_usernameField, "App_Tests2");
    await tester.pump();
  }

  Future<void> inputEmail() async {
    await tester.enterText(_emailField, "app_tests2@freequiz.ch");
    await tester.pump();
  }

  Future<void> inputPassword() async {
    await tester.enterText(_passwordField, "AppTests2");
    await tester.pump();
  }

  Future<void> inputPasswordConfirmation() async {
    await tester.enterText(_passwordConfirmationField, "AppTests2");
    await tester.pump();
  }

  Future <void> submit() async {
    await tester.tap(_submitButton);
    await tester.pumpAndSettle();
  }
  
  SignupScreen(this.tester);
}