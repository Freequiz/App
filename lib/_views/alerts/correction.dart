import 'package:easy_localization/easy_localization.dart';
import 'package:freequiz/utilities/imports/base.dart';

class Correction extends StatelessWidget {
  final String givenAnswer;
  final String rightAnswer;
  const Correction({super.key, required this.givenAnswer, required this.rightAnswer});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return AlertDialog(
      title: const Text('answer wrong').tr(),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('right answer').tr(),
          Text(
            rightAnswer,
            style: const TextStyle(fontSize: FontSize.title, color: greenMedium, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: height / 32),
          const Text('your answer').tr(),
          Text(
            givenAnswer,
            style: const TextStyle(fontSize: FontSize.title, color: redMedium, fontWeight: FontWeight.w600),
          ),
        ],
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text('answer right').tr(),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('close').tr(),
            ),
          ],
        ),
      ],
    );
  }
}
