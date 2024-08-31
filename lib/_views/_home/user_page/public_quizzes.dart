import 'package:freequiz/_views/subviews/quiz_tile/quiz_tile.dart';
import 'package:freequiz/_views/_home/user_page/user_data.dart';
import 'package:freequiz/utilities/imports/utilities.dart';

class PublicQuizzes extends StatefulWidget {
  final String user;
  const PublicQuizzes({super.key, required this.user});

  @override
  State<PublicQuizzes> createState() => _PublicQuizzesState();
}

class _PublicQuizzesState extends State<PublicQuizzes> {
  bool pressed = false;
  int page = 1;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: PublicUserData.data.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int i) {
        return QuizTile(
          data: PublicUserData.data[i],
          uuid: PublicUserData.data[i]['id'],
          expanded: false,
          width: context.screenWidth - 20,
        );
      },
      separatorBuilder: (BuildContext context, int i) {
        return Space.height(context.mobileLayout ? 10 : 20);
      },
    );
  }
}
