import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:camera/camera.dart';

class CameraService {
  final TextRecognizer _textRecognizer = TextRecognizer();

  Future<String> processImage(XFile image) async {
    final inputImage = InputImage.fromFilePath(image.path);
    final RecognizedText recognizedText = await _textRecognizer.processImage(inputImage);
    
    // Logic: Medicine names are usually the largest text or at the top
    // For now, we return the whole block; we will refine this with Gemini
    return recognizedText.text;
  }

  void dispose() {
    _textRecognizer.close();
  }
}