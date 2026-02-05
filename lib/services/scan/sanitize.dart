import 'package:freequiz/utilities/imports/base.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

void sanitize(RecognizedText recognizedText, int width) {
  List<Map> wordPairs = [];

  debugPrint(width.toString());

  for (int i = 0; i < recognizedText.blocks.length; i++) {
    TextBlock block = recognizedText.blocks[i];
    for (TextLine line in block.lines) {
      Map wordPair = {
        "y": line.elements.first.cornerPoints.first.y,
        "definition": "",
        "answer": ""
      };

      for (TextElement element in  line.elements) {
        debugPrint("${element.text} -> ${element.recognizedLanguages.toString()} \n${element.cornerPoints[0]}");
        if (filter(element)) {
          if (element.cornerPoints.first.x > width / 2 - 200) {
            wordPair["answer"] += "${element.text} ";
          }
          else {
            wordPair["definition"] += "${element.text} ";
          } 
        }
      }

      if (wordPair["answer"] == "" && wordPair["definition"] == "") continue;

      wordPairs.add(wordPair);
    }
  }
  match(wordPairs);
  debugPrint(wordPairs.toString()); 
}

void match(List<Map> wordPairs) {
  wordPairs.sort((a, b) => a["y"].compareTo(b["y"]));

  for (int i = 0; i < wordPairs.length; i++) {
    Map wordPair = wordPairs[i];
    if (wordPair["definition"] != "" && wordPair["answer"] != "") continue;
    if (i + 1 > wordPairs.length - 1) continue;

    Map nextPair = wordPairs[i+1];
    if (nextPair["y"] - wordPair["y"] > 50) {
      if (i - 1 < 0) continue;

      Map lastPair = wordPairs[i - 1];
      if (wordPair["y"] - lastPair["y"] > 150) continue;

      wordPairs[i - 1]["answer"] += wordPair["answer"];
      wordPairs[i - 1]["definition"] += wordPair["definition"];

      wordPairs.removeAt(i);
      i--;
      continue;
    } 

    if (nextPair["answer"] == "" && wordPair["answer"] == "") continue;
    if (nextPair["definition"] == "" && wordPair["definition"] == "") continue;

    wordPair["answer"] += nextPair["answer"];
    wordPair["definition"] += nextPair["definition"];

    wordPairs.removeAt(i+1);
  }
}  

bool filter(TextElement element) {
  final invalidCharacters = RegExp(r'[0-9\[\]ɛſə|æãā]');
  if (invalidCharacters.hasMatch(element.text)) {
    debugPrint("INVALID (invalid character): ${element.text}");
    return false;
  }

  final capitalizedLetterInside = RegExp(r'^.{1,}[A-Z].*$');
  if (capitalizedLetterInside.hasMatch(element.text)) {
    debugPrint("INVALID (capitalized letter inside): ${element.text}");
    return false;
  }

  final unbalancedParenthesis = RegExp(r'\((?!.*\))');
  if (unbalancedParenthesis.hasMatch(element.text)) {
    debugPrint("INVALID (unbalanced paranthesis): ${element.text}");
    return false;
  }

  return true;
}