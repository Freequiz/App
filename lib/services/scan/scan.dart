import 'dart:io';
import 'dart:ui' as ui;
import 'package:freequiz/services/scan/sanitize.dart';
import 'package:freequiz/utilities/imports/base.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';


Future<List<Map>> scan() async {
  debugPrint("Scanning...");

  final InputImage? inputImage = await pickImage();
  if (inputImage == null) return [];

  final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
  final RecognizedText recognizedText = await textRecognizer.processImage(inputImage);

  final wordPairs = sanitize(recognizedText, await getWidth(inputImage));

  await textRecognizer.close();
  return wordPairs;
}

Future<InputImage?> pickImage() async {
  final picker = ImagePicker();
  final picked = await picker.pickImage(source: ImageSource.gallery);

  if (picked == null) {
    debugPrint('No image selected');
    return null;
  }

  return InputImage.fromFilePath(picked.path);
}

Future<int> getWidth(InputImage image) async {
  final bytes = await File(image.filePath!).readAsBytes();
  final ui.Image decoded = await decodeImageFromList(bytes);
  return decoded.width;
}