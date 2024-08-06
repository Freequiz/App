import 'package:freequiz/utilities/imports/base.dart';
import 'package:material_symbols_icons/symbols.dart';

class AddButton extends StatelessWidget {
  final Function add;

  const AddButton({super.key, required this.add});

  @override
  Widget build(BuildContext context) {
    return Align(
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: context.darkMode ? gray60 : blueLight,
          foregroundColor: context.darkMode ? Colors.white : gray40,
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        ),
        onPressed: () => add(),
        child: const Icon(
          Symbols.add,
          color: Colors.white,
          weight: 900,
          grade: 200,
          opticalSize: 24,
        ),
      ),
    );
  }
}
