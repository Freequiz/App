import 'package:freequiz/utilities/imports/base.dart';

class AppBarTitle extends StatelessWidget {
  const AppBarTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Text(
          "Freequiz",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 30.0,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 1.0
              ..color = gray40,
          ),
        ),
        const Text(
          "Freequiz",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 30.0,
          ),
        ),
      ],
    );
  }
}
