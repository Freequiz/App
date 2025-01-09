import 'dart:math';

import 'package:freequiz/utilities/imports/utilities.dart';

class EditController extends ChangeNotifier {
  Key key = Key(Random().toString());

  refresh() {
    key = Key(Random().toString());
    notifyListeners();
  }
}