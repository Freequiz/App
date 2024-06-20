import 'package:freequiz/utilities/imports/base.dart';

class AddButton extends StatelessWidget {

  final Function add;

  const AddButton({super.key, required this.add});

  @override
  Widget build(BuildContext context) {
    return Align(
      child: TextButton(
        style: TextButton.styleFrom(backgroundColor: grayFreequiz, foregroundColor: Colors.white),
        onPressed: () => add(),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
