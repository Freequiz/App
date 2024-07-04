import 'package:easy_localization/easy_localization.dart';
import 'package:freequiz/utilities/imports/base.dart';

class CategoryTitle extends StatelessWidget {
  final IconData icon;
  final ColorFamily color;
  final String title;
  const CategoryTitle({super.key, required this.icon, required this.color, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: color.light,
            ),
            padding: const EdgeInsets.all(5.0),
            child: Icon(
              icon,
              size: 32,
              color: color.dark,
            ),
          ),
          const SizedBox(width: 15.0),
          Text(
            context.tr(title),
            style: const TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: FontSize.title,
            ),
          ),
        ],
      ),
    );
  }
}
