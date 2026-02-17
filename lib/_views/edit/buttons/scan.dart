import 'package:freequiz/_views/edit/scan.dart/pop_up.dart';
import 'package:freequiz/utilities/imports/utilities.dart';

class ScanButton extends StatelessWidget {
  final Function refresh;
  const ScanButton({super.key, required this.refresh});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: TextButton(
        style: TextButton.styleFrom(backgroundColor: grayFreequiz, foregroundColor: Colors.white),
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) => ScanPopUp(refresh: refresh),
          );
        },
        child: const Icon(
          Icons.camera_alt_outlined,
          color: Colors.white,
        ),
      ),
    );
  }
}
