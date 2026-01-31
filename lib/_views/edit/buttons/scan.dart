import 'package:freequiz/services/scan/scan.dart';
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
          scan();
        },
        child: const Icon(
          Icons.camera_alt_outlined,
          color: Colors.white,
        ),
      ),
    );
  }
}
