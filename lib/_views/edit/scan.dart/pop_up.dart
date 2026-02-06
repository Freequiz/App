import 'package:easy_localization/easy_localization.dart';
import 'package:freequiz/_views/edit/scan.dart/scan.dart';
import 'package:freequiz/controllers/edit/scan.dart';
import 'package:freequiz/utilities/imports/base.dart';

class ScanPopUp extends StatelessWidget {
  final Function refresh;
  const ScanPopUp({super.key, required this.refresh});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        context.tr("scan quiz"),
        style: TextStyle(color: context.darkMode ? Colors.white : Colors.black),
      ),
      content: SizedBox(),
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
                await Scan.main();
                if (!context.mounted) return;
                
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => ScanQuiz(refresh: refresh),
                ));
              },
              child: const Text("done").tr(),
            ),
          ],
        )
      ],
    );
  }
}
