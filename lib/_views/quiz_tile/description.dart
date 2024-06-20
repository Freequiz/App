import 'package:freequiz/utilities/imports/base.dart';

class Description extends StatelessWidget {
  const Description(
      {super.key,
      required this.expanded,
      required this.width,
      required this.description});

  final bool expanded;
  final double width;
  final String description;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: expanded
          ? context.mobileLayout
              ? width - 20
              : width - 40
          : context.mobileLayout
              ? width / 6 * 5 - 20
              : width / 6 * 5 - 40,
      child: Text(
        description,
        maxLines: expanded ? 2 : 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: context.screenHeight/ 60,
        ),
      ),
    );
  }
}
