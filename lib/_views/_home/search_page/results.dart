import 'package:flutter_animate/flutter_animate.dart';
import 'package:freequiz/controllers/home/search.dart';
import 'package:freequiz/_views/subviews/buttons/load_more.dart';
import 'package:freequiz/utilities/imports/utilities.dart';
import 'package:provider/provider.dart';

class Results extends StatelessWidget {
  final Widget child;
  final int i;
  final bool more;

  const Results({
    super.key,
    required this.child,
    required this.i,
    required this.more
  });

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<Search>(context);

    return Positioned.fill(
      child: ListView(
        children: [
          child,
          SizedBox(
            height: context.mobileLayout ? 10 : 15,
          ),
          LoadMoreButton(
            onPressed: () => controller.onPressed(i),
            pressed: controller.pressed,
            more: more,
          ),
        ],
      )
          .animate(target: controller.onChanged ? 1 : 0)
          .moveX(
            begin: context.screenWidth * (i - controller.previousShownList),
            end: context.screenWidth * (i - controller.shownList),
            duration: const Duration(milliseconds: 200),
          )
          .callback(
        callback: (_) {
          if (i != 0) return; //only call this once
          controller.endAnimation();
        },
      ),
    );
  }
}
