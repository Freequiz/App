import 'package:freequiz/_views/edit/pop_ups/import.dart';
import 'package:freequiz/utilities/imports/utilities.dart';

class ImportButton extends StatelessWidget {
  final Function refresh;
  const ImportButton({super.key, required this.refresh});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: TextButton(
        style: TextButton.styleFrom(backgroundColor: grayFreequiz, foregroundColor: Colors.white),
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) => ImportPopUp(refresh: refresh),
          );
        },
        child: const Icon(
          Icons.download_rounded,
          color: Colors.white,
        ),
      ),
    );
  }
}
