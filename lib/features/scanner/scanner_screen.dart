import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:ki_oushudh/features/scanner/result_screen.dart';
import 'package:ki_oushudh/services/ai_service.dart';
import '../../services/camera_service.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  _ScannerScreenState createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  CameraController? _controller;
  final CameraService _cameraService = CameraService();
  final AIService _aiService = AIService(); // Keep this as a class member
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    _setupCamera();
  }

  Future<void> _setupCamera() async {
    final cameras = await availableCameras();
    if (cameras.isEmpty) return;
    
    _controller = CameraController(cameras[0], ResolutionPreset.medium);
    await _controller!.initialize();
    if (!mounted) return;
    setState(() {});
  }

  Future<void> _scanMedicine() async {
    if (_isProcessing || _controller == null || !_controller!.value.isInitialized) return;

    setState(() => _isProcessing = true);

    try {
      final image = await _controller!.takePicture();
      final rawText = await _cameraService.processImage(image);
      
      // Get Bangla info from Gemini
      final banglaInfo = await _aiService.getMedicineInfo(rawText);
      
      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ResultScreen(info: banglaInfo)),
        );
      }
    } catch (e) {
      debugPrint("Error scanning: $e");
    } finally {
      if (mounted) setState(() => _isProcessing = false);
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_controller == null || !_controller!.value.isInitialized) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      body: Stack(
        children: [
          // Full screen camera preview
          Positioned.fill(child: CameraPreview(_controller!)),

          // High-contrast Scanner Overlay (Box for elderly guidance)
          _buildScannerOverlay(),

          // Floating Action Button
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 60),
              child: FloatingActionButton.large(
                onPressed: _scanMedicine,
                backgroundColor: Colors.green,
                child: _isProcessing 
                    ? const CircularProgressIndicator(color: Colors.white) 
                    : const Icon(Icons.camera_alt, size: 45, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper widget to draw a box on the camera
  Widget _buildScannerOverlay() {
    return ColorFiltered(
      colorFilter: ColorFilter.mode(
        Colors.black.withOpacity(0.5),
        BlendMode.srcOut,
      ),
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.black,
              backgroundBlendMode: BlendMode.dstOut,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              height: 250,
              width: 320,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}