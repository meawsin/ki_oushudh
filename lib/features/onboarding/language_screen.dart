import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/constants/app_strings.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  // Function to save language and navigate
  Future<void> _setLanguage(BuildContext context, String langCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_lang', langCode);
    await prefs.setBool('is_first_run', false);

    // After selecting, move to the Scanner Screen (we'll build this next)
    if (context.mounted) {
      Navigator.pushReplacementNamed(context, '/scanner');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.medication_liquid, size: 100, color: Colors.green),
              const SizedBox(height: 20),
              const Text(
                AppStrings.welcomeBn,
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const Text(
                AppStrings.welcomeEn,
                style: TextStyle(fontSize: 20, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 50),
              
              // Bangla Button - Huge and Green
              LanguageButton(
                title: "বাংলা",
                subtitle: "Bangla",
                color: Colors.green.shade700,
                onTap: () => _setLanguage(context, 'bn'),
              ),
              
              const SizedBox(height: 20),
              
              // English Button - Large and Blue
              LanguageButton(
                title: "English",
                subtitle: "ইংরেজি",
                color: Colors.blue.shade700,
                onTap: () => _setLanguage(context, 'en'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Custom widget for high-accessibility buttons
class LanguageButton extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  const LanguageButton({super.key, 
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 100, // Large height for shaky hands
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
        onPressed: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
            Text(subtitle, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}