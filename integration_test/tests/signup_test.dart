import 'package:flutter_test/flutter_test.dart';
import 'package:freequiz/main.dart' as app;
import 'package:integration_test/integration_test.dart';

import '../screens/deletion_confirmation_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/root_screen.dart';
import '../screens/signup_screen.dart';
import '../screens/welcome_screen.dart';

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;

  testWidgets(
    'Test Sign up',
    (WidgetTester tester) async {
      app.main();
      await tester.pump(const Duration(seconds: 10));

      WelcomeScreen welcomeScreen = WelcomeScreen(tester);
      await welcomeScreen.navigateToSignup();

      final signupScreen = SignupScreen(tester);
      await signupScreen.inputUsername();
      await signupScreen.inputEmail();
      await signupScreen.inputPassword();
      await signupScreen.inputPasswordConfirmation();
      await signupScreen.submit();

      final rootScreen = RootScreen(tester);
      rootScreen.checkForAppBar();
      await rootScreen.navigateToProfilePage();

      final profileScreen = ProfileScreen(tester);
      await profileScreen.deleteAccount();

      final deletionConfirmationScreen = DeletionConfirmationScreen(tester);
      await deletionConfirmationScreen.deleteAccount();

      welcomeScreen = WelcomeScreen(tester);
      welcomeScreen.checkForButtons();
    },
    skip: false,
    timeout: const Timeout(Duration(minutes: 5)),
  );
}
