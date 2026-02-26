import 'dart:io';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class OCRService {
  late TextRecognizer _textRecognizer;

  OCRService() {
    // Initialize the text recognizer (defaulting to Latin script)
    _textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
  }

  /// Extracts text from the given image file.
  Future<String> extractText(File imageFile) async {
    try {
      final inputImage = InputImage.fromFile(imageFile);
      final RecognizedText recognizedText = await _textRecognizer.processImage(
        inputImage,
      );

      String text = recognizedText.text;

      if (text.isEmpty) {
        return "No text found in the image.";
      }

      return text;
    } catch (e) {
      return "Error recognizing text: ${e.toString()}";
    }
  }

  /// Disposes the text recognizer to free up resources.
  void dispose() {
    _textRecognizer.close();
  }
}
