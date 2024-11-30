import 'package:easy_localization/easy_localization.dart';
import 'package:freequiz/_views/_home/learning/cards/cards_body.dart';
import 'package:freequiz/controllers/home/learning/cards.dart';
import 'package:freequiz/utilities/imports/utilities.dart';
import 'package:provider/provider.dart';

class Cards extends StatelessWidget {
  const Cards({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<CardsController>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'cards',
          style: TextStyle(color: Colors.white),
        ).tr(),
        backgroundColor: context.darkMode ? blueDark : blueLight,
        foregroundColor: Colors.white,
      ),
      body: CardsBody(
        key: controller.key,
        wrong: () => controller.wrong(context),
        right: () => controller.right(context),
        back: () => controller.back(),
        color: blue,
      ),
    );
  }
}
