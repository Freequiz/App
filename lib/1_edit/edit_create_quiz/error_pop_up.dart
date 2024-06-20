import 'package:easy_localization/easy_localization.dart';
import 'package:freequiz/utilities/imports/utilities.dart';

class ErrorPopUp extends StatelessWidget {
  const ErrorPopUp({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        context.tr('not enough words'),
        style: TextStyle(color: context.darkMode ? Colors.white : Colors.black),
      ),
      content: const Text('not enough words description').tr(),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('close').tr(),
        )
      ],
    );
  }
}
