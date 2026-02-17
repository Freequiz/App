import 'package:freequiz/_views/edit/scan.dart/pop_up.dart';
import 'package:freequiz/utilities/imports/base.dart';
import 'package:material_symbols_icons/symbols.dart';

class ScanButton extends StatelessWidget {
  final Function refresh;

  const ScanButton({super.key, required this.refresh});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 70,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: context.darkMode ? gray60 : blueLight,
          foregroundColor: context.darkMode ? Colors.white : gray40,
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        ),
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) => ScanPopUp(refresh: refresh, addToExisting: true),
          );
        },
        child: const Icon(
          Symbols.camera_alt_rounded,
          color: Colors.white,
          weight: 900,
          grade: 200,
          opticalSize: 24,
        ),
      ),
    );
  }
}
