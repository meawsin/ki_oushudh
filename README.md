# Ki Oushodh (কি ঔষধ) - The AI Pharmacist

Ki Oushodh is a Flutter-based assistive technology designed for the elderly and underpriviliged in Bangladesh. It uses on-device OCR and Gemini AI to identify English medicine names and explain their usage in spoken Bangla.

##  Medical Disclaimer
**IMPORTANT:** This application is for informational and educational purposes only. The information provided by the AI (Gemini) can be inaccurate (hallucinations). Users must never rely solely on this app for medical decisions. Always consult a certified pharmacist or doctor.

## Key Features
- **Language First:** Onboarding screen for Bangla/English selection.
- **Elderly-Centric UI:** Large buttons, high-contrast colors, and voice-first feedback.
- **On-Device OCR:** Uses Google ML Kit for instant English text extraction.
- **AI Explanation:** Powered by Google Gemini for context-aware medicine descriptions.
- **Voice Output:** Converts Bangla text to clear audio for accessibility.

## Tech Stack
- **Framework:** Flutter
- **OCR:** `google_mlkit_text_recognition`
- **AI:** `google_generative_ai` (Gemini API)
- **Voice:** `flutter_tts`
- **State Management:** `provider` or `bloc` (Recommended for scalability)