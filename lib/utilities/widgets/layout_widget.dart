import 'package:freequiz/utilities/imports/base.dart';

class LayoutWidget extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;

  const LayoutWidget({super.key, this.mobile = const SizedBox(), this. tablet = const SizedBox()});

  @override
  Widget build(BuildContext context) {
    if (context.mobileLayout) return mobile;
    return tablet;
  }
}