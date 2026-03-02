import 'package:flutter_test/flutter_test.dart';
import 'package:freequiz/main.dart' as app;
import 'package:integration_test/integration_test.dart';

import '../screens/login_screen.dart';
import '../screens/root_screen.dart';
import '../screens/welcome_screen.dart';

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;

  testWidgets(
    'Test Login',
    (WidgetTester tester) async {
      app.main();
      await tester.pump(const Duration(seconds: 5));

      final welcomeScreen = WelcomeScreen(tester);
      await welcomeScreen.navigateToLogin();
      
      final loginScreen = LoginScreen(tester);
      await loginScreen.inputUsername();
      await loginScreen.inputPassword();
      await loginScreen.submit();

      final rootScreen = RootScreen(tester);
      rootScreen.checkForAppBar();
    },
    skip: false,
    timeout: const Timeout(Duration(minutes: 5)),
  );
}
