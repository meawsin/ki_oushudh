import 'package:flutter/material.dart';
import 'package:ki_oushudh/features/onboarding/language_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final bool isFirstRun = prefs.getBool('is_first_run') ?? true;

  runApp(KiOushodhApp(showOnboarding: isFirstRun));
}

class KiOushodhApp extends StatelessWidget {
  final bool showOnboarding;
  const KiOushodhApp({required this.showOnboarding});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.green),
      // Set the initial route based on whether it's the first run
      initialRoute: showOnboarding ? '/' : '/scanner',
      routes: {
        '/': (context) => const LanguageScreen(),
        '/scanner': (context) => const Placeholder(), // We will replace this with CameraScreen next
      },
    );
  }
}