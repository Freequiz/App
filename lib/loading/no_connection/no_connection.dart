import 'package:easy_localization/easy_localization.dart';
import 'package:freequiz/utilities/imports/base.dart';

class NoConnectionAlert extends StatelessWidget {
  final Color? backgroundColor;
  final bool showButton;

  const NoConnectionAlert({super.key, this.backgroundColor, this.showButton = true});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        context.tr('no connection title'),
      ),
      backgroundColor: backgroundColor,
      content: const Text('no connection description').tr(),
      actions: showButton
          ? [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('close').tr(),
              ),
            ]
          : null,
    );
  }
}
