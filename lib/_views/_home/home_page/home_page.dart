import 'package:flutter_animate/flutter_animate.dart';
import 'package:freequiz/_views/edit/pop_ups/confirmation.dart';
import 'package:freequiz/_views/_home/home_page/switcher.dart';
import 'package:freequiz/_views/subviews/category_title.dart';
import 'package:freequiz/controllers/home/home_page.dart';
import 'package:freequiz/loading/load_quiz_list.dart';
import 'package:freequiz/utilities/imports/utilities.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<HomePageController>(context); // Access controller

    removePersonal(int i, String uuid) {
      showDialog(
        context: context,
        builder: (BuildContext context) => Confirmation(refresh: () {}, uuid: uuid),
      );
    }

    final List<Function> functions = [HomePageController.removeRecent, HomePageController.removeFavorite, removePersonal];

    Widget listQuizMobile(int i) {
      return Positioned.fill(
        child: LoadQuizList(
          key: HomePageController.keys[i],
          future: HomePageController.listQuizzes[i],
          background: HomePageController.backgrounds[i],
          onDismissed: functions[i],
        )
            .animate(target: HomePageController.onChanged ? 1 : 0)
            .moveX(
              begin: context.screenWidth * (i - HomePageController.previousShownQuizzes),
              end: context.screenWidth * (i - HomePageController.shownQuizzes),
              duration: const Duration(milliseconds: 200),
            )
            .callback(
          callback: (_) => controller.callback(i),
        ),
      );
    }

    Widget listQuizTablet(int i) {
      return SizedBox(
        height: 152,
        child: LoadQuizList(
          key: HomePageController.keys[i],
          future: HomePageController.listQuizzes[i],
          onDismissed: functions[i],
          background: HomePageController.backgrounds[i],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () => controller.onRefresh(),
      child: LayoutWidget(
        mobile: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            HomePageSwitcher(onTap: controller.onTap, options: HomePageController.options),
            SizedBox(
              height: context.mobileLayout ? 10 : 30,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Stack(
                  children: [
                    listQuizMobile(0),
                    listQuizMobile(1),
                    listQuizMobile(2),
                  ],
                ),
              ),
            ),
          ],
        ),
        tablet: ListView(
          padding: const EdgeInsets.all(15.0),
          children: [
            CategoryTitle(icon: Icons.history, color: rose, title: 'history'),
            listQuizTablet(0),
            const SizedBox(height: 15.0),
            CategoryTitle(icon: Icons.star_rounded, color: purple, title: 'favorite'),
            listQuizTablet(1),
            const SizedBox(height: 15.0),
            CategoryTitle(icon: Icons.person, color: beige, title: 'created quizzes'),
            listQuizTablet(2),
          ],
        ),
      ),
    );
  }
}
