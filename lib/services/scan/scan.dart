import 'package:freequiz/utilities/imports/base.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';


Future<void> scan() async {
  debugPrint("Scanning...");
  final InputImage? inputImage = await pickImage();
  if (inputImage == null) return;

  final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);

  final RecognizedText recognizedText = await textRecognizer.processImage(inputImage);

  String text = recognizedText.text;
  debugPrint(text);
  
  await textRecognizer.close();
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