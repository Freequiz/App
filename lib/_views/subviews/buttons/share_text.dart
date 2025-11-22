import 'package:freequiz/utilities/imports/base.dart';
import 'package:share_plus/share_plus.dart';

class ShareTextButton extends StatelessWidget {
  final String url;

  const ShareTextButton({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        final RenderBox box = context.findRenderObject() as RenderBox;
        SharePlus.instance.share(
          ShareParams(text: url, sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size),
        );
      },
      child: const Icon(
        Icons.ios_share,
        size: 24,
      ),
    );
  }
}