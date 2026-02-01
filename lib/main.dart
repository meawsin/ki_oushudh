import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:ki_oushudh/features/onboarding/language_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'features/scanner/scanner_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await dotenv.load(fileName: ".env");
    print("Environment loaded successfully");
  } catch (e) {
    print("Error loading .env file: $e");
  }
  final prefs = await SharedPreferences.getInstance();
  
  final apiKey = dotenv.env['GEMINI_API_KEY'];
  print("API KEY CHECK: ${apiKey != null ? 'Found' : 'NOT FOUND'}");

  final bool isFirstRun = prefs.getBool('is_first_run') ?? true;

  runApp(KiOushodhApp(showOnboarding: isFirstRun));
}

class KiOushodhApp extends StatelessWidget {
  final bool showOnboarding;
  const KiOushodhApp({super.key, required this.showOnboarding});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.green),
      // Set the initial route based on whether it's the first run
      initialRoute: showOnboarding ? '/' : '/scanner',
      routes: {
        '/': (context) => const LanguageScreen(),
        '/scanner': (context) => const ScannerScreen(), // We will replace this with CameraScreen next
      },
    );
  }
}