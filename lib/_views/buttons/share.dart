import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class ShareButton extends StatelessWidget {
  const ShareButton({super.key, required this.url, this.color = Colors.white});

  final String url;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final RenderBox box = context.findRenderObject() as RenderBox;
        Share.share(url, sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,);
      },
      child: Icon(
        Icons.ios_share,
        color: color,
      ),
    );
  }
}