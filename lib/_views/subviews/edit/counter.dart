import 'package:freequiz/utilities/imports/utilities.dart';

class Counter extends StatelessWidget {
  final int amount;
  const Counter({super.key, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 7),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(1000),
        border: Border.all(
          width: 3,
          color: context.darkMode ? gray60 : blueLight,
        ),
      ),
      alignment: Alignment.center,
      width: 70,
      child: Text(
        amount.toString(),
        style: buttonStyle(),
      ),
    );
  }
}
