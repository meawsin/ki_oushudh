import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AIService {
  late final GenerativeModel _model;

  AIService() {
  final apiKey = dotenv.env['GEMINI_API_KEY'] ?? "";
    _model = GenerativeModel(
      model: 'gemini-1.5-flash',
      apiKey: apiKey,
      generationConfig: GenerationConfig(
        temperature: 0.1, 
        maxOutputTokens: 100,
      ),
    );
  }
  Future<String> getMedicineInfo(String rawText) async {

    final prompt = """
    Analyze this text from a medicine package: "$rawText".
    1. Identify the medicine name.
    2. Provide exactly two sentences in simple Bangla.
    3. Sentence 1: What the medicine is used for.
    4. Sentence 2: One vital safety rule (e.g., take after food).
    If no medicine is found, say: "দুঃখিত, আমি ঔষধটি চিনতে পারছি না।"
    Do not use bold text or special characters.
    """;

    try {
      final response = await _model.generateContent([Content.text(prompt)]);
      
      if (response.text == null || response.text!.isEmpty) {
        return "দুঃখিত, কোনো তথ্য পাওয়া যায়নি।";
      }
      
      return response.text!.trim();
    } catch (e) {
      print("REAL ERROR: $e");
      if (e.toString().contains('User location is not supported')) {
        return "আপনার এলাকায় এই সেবাটি উপলব্ধ নেই।";
      }
      return "ইন্টারনেট সংযোগ পরীক্ষা করুন।";
    }
  }
}