import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AIService {
  late final GenerativeModel _model;

  AIService() {
    final apiKey = dotenv.env['GEMINI_API_KEY'] ?? "";
    _model = GenerativeModel(
      model: 'gemini-1.5-flash',
      apiKey: apiKey,
    );
  }

  Future<String> getMedicineInfo(String rawText) async {
    // This prompt is the "Secret Sauce" for elderly safety
    final prompt = """
    I scanned a medicine box and found this text: "$rawText".
    Identify the medicine name. 
    Explain what it is for and a safety warning in exactly 2 short sentences in simple Bangla.
    Example: "এটি নাপা। এটি জ্বর ও ব্যথার জন্য। খাওয়ার পরে সেবন করুন।"
    If you cannot find a medicine name, say: "দুঃখিত, আমি ঔষধটি চিনতে পারছি না।"
    """;

    try {
      final content = [Content.text(prompt)];
      final response = await _model.generateContent(content);
      return response.text ?? "তথ্য পাওয়া যায়নি।";
    } catch (e) {
      print("REAL ERROR: $e"); 
    return "Error: $e"; //
    }
  }
}