import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraPreviewWidget extends StatefulWidget {
  final Function(File image) onImageCaptured;
  final bool autoCapture;
  final Duration captureInterval;

  const CameraPreviewWidget({
    super.key,
    required this.onImageCaptured,
    this.autoCapture = true,
    this.captureInterval = const Duration(milliseconds: 800),
  });

  @override
  State<CameraPreviewWidget> createState() =>
      _CameraPreviewWidgetState();
}

class _CameraPreviewWidgetState extends State<CameraPreviewWidget> {
  late CameraController _controller;
  late List<CameraDescription> _cameras;

  bool _isReady = false;
  bool _isCapturing = false;

  Timer? _captureTimer;

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  Future<void> _initCamera() async {
    _cameras = await availableCameras();

    _controller = CameraController(
      _cameras.firstWhere(
            (c) => c.lensDirection == CameraLensDirection.front,
      ),
      ResolutionPreset.medium,
      enableAudio: false,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );

    await _controller.initialize();

    if (!mounted) return;

    setState(() => _isReady = true);

    if (widget.autoCapture) {
      _startAutoCapture();
    }
  }

  void _startAutoCapture() {
    _captureTimer?.cancel();

    _captureTimer = Timer.periodic(
      widget.captureInterval,
          (_) => _captureFrame(),
    );
  }

  Future<void> _captureFrame() async {
    if (!_controller.value.isInitialized) return;
    if (_isCapturing) return;

    try {
      _isCapturing = true;

      final file = await _controller.takePicture();
      widget.onImageCaptured(File(file.path));
    } catch (_) {
      // swallow camera errors silently
    } finally {
      _isCapturing = false;
    }
  }

  @override
  void dispose() {
    _captureTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isReady) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return SizedBox.expand(
      child: CameraPreview(_controller),
    );
  }
}
