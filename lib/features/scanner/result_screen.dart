import 'package:flutter/material.dart';
import '../../services/voice_service.dart';

class ResultScreen extends StatefulWidget {
  final String info;
  const ResultScreen({super.key, required this.info});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  final VoiceService _voice = VoiceService();

  @override
  void initState() {
    super.initState();
    _voice.speakBangla(widget.info); // Auto-speak when screen opens
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("ওষুধের তথ্য")),
      body: SafeArea(
        child: SingleChildScrollView(
          // Prevents the overflow error
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.volume_up, size: 80, color: Colors.green),
                const SizedBox(height: 20),
                Text(
                  widget.info,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 70),
                    backgroundColor: Colors.orange,
                  ),
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.refresh, color: Colors.white),
                  label: const Text("আবার স্ক্যান করুন",
                      style: TextStyle(fontSize: 20, color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
