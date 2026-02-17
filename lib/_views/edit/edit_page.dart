import 'dart:math';
import 'package:freequiz/_views/edit/buttons/create.dart';
import 'package:freequiz/_views/edit/buttons/import.dart';
import 'package:freequiz/_views/edit/buttons/scan.dart';
import 'package:freequiz/loading/load_draft.dart';
import 'package:freequiz/loading/load_edit.dart';
import 'package:freequiz/utilities/imports/utilities.dart';


class EditPage extends StatefulWidget {
  const EditPage({super.key});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  bool draft = false;
  Key key = Key(Random().toString());

  void refresh() {
    setState(() {
      key = Key(Random().toString());
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          color: context.darkMode ? darkMainColor : lightMainColor,
          width: double.maxFinite,
          padding: EdgeInsets.only(
            right: context.mobileLayout ? 0.0 : 20,
            left: context.mobileLayout ? 0.0 : 20,
            top: 10,
            bottom: 15.0,
          ),
          child: IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ImportButton(refresh: refresh),
                const SizedBox(width: 10),
                CreateButton(refresh: refresh),
                const SizedBox(width: 10),
                ScanButton(refresh: refresh),
              ],
            ),
          )
        ),
        SizedBox(height: context.mobileLayout ? 15 : 45),
        LoadDraft(refresh: refresh),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: LoadEdit(
              keyChild: key,
              refresh: refresh,
            ),
          ),
        ),
      ],
    );
  }
}
