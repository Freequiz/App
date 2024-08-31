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
    return Flexible(
      child: Text(
        description,
        maxLines: expanded ? 2 : 1,
        overflow: TextOverflow.ellipsis,
        style: fontSize(FontSize.text)
      ),
    );
  }
}
