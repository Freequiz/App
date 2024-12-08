import 'package:easy_localization/easy_localization.dart';
import 'package:freequiz/utilities/imports/themes.dart';

class Confirmation extends StatelessWidget {
  final Function reset;
  final int i;
  const Confirmation({super.key, required this.reset, required this.i});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        context.tr('delete progress'),
        style: TextStyle(color: context.darkMode ? Colors.white : Colors.black),
      ),
      content: const Text('confirmation delete progress').tr(),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  reset();
                  Navigator.of(context).pop();
                },
                child: Text(
                  context.tr('delete'),
                  style: const TextStyle(color: Colors.red),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('close').tr(),
              )
            ],
          ),
        ),
      ],
    );
  }
}
