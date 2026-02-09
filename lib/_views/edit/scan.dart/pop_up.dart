import 'package:easy_localization/easy_localization.dart';
import 'package:freequiz/_views/edit/scan.dart/scan.dart';
import 'package:freequiz/controllers/edit/scan.dart';
import 'package:freequiz/utilities/imports/utilities.dart';

class ScanPopUp extends StatefulWidget {
  final Function refresh;
  final bool addToExisting;
  const ScanPopUp({super.key, required this.refresh, this.addToExisting = false});

  @override
  State<ScanPopUp> createState() => _ScanPopUpState();
}

class _ScanPopUpState extends State<ScanPopUp> {
  bool processing = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        context.tr("scan quiz"),
        style: TextStyle(color: context.darkMode ? Colors.white : Colors.black),
      ),
      content: Conditional(
          condition: processing,
          widget: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
            ],
          ),
          defaultWidget: const Text("scan quiz text").tr()),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("close").tr(),
            ),
            TextButton(
              onPressed: () async {
                setState(() {
                  processing = true;
                });
                await Scan.main();
                if (!context.mounted) return;

                Navigator.of(context).pop();

                if (!widget.addToExisting) {
                  Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) =>
                      ScanQuiz(refresh: widget.refresh),
                  ));
                  return;
                }

                widget.refresh();
              },
              child: Visibility(visible: !processing, child: const Text("okay").tr()),
            ),
          ],
        )
      ],
    );
  }
}
