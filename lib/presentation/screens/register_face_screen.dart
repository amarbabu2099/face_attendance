import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/face_auth/face_auth_bloc.dart';
import '../../application/face_auth/face_auth_event.dart';
import '../../application/face_auth/face_auth_state.dart';

import '../../core/utils/face_detector_service.dart';
import '../../core/utils/face_cropper.dart';
import '../../core/utils/face_selection_helper.dart';
import '../../core/utils/liveness_checker.dart';

import '../widgets/camera_preview_widget.dart';

class RegisterFaceScreen extends StatefulWidget {
  const RegisterFaceScreen({super.key});

  @override
  State<RegisterFaceScreen> createState() =>
      _RegisterFaceScreenState();
}

enum _RegisterStatus { idle, info, processing, success, error }

class _RegisterFaceScreenState extends State<RegisterFaceScreen> {
  final _nameController = TextEditingController();

  bool _busy = false;
  String _message = 'Enter name and position face inside the frame';
  _RegisterStatus _status = _RegisterStatus.idle;

  Future<void> _processFrame(File image) async {
    if (_busy) return;

    final name = _nameController.text.trim();
    if (name.isEmpty) {
      _set('Name is required', _RegisterStatus.info);
      return;
    }

    _busy = true;

    try {
      final faces = await FaceDetectorService.detectFaces(image);
      final selection =
      FaceSelectionHelper.selectSingleFace(faces);

      if (!selection.isValid) {
        _set(selection.error!, _RegisterStatus.info);
        _busy = false;
        return;
      }

      if (!LivenessChecker.isLive(selection.face!)) {
        _set('Blink or turn your head', _RegisterStatus.info);
        _busy = false;
        return;
      }

      _set('Registering face…', _RegisterStatus.processing);

      final cropped =
      await FaceCropper.cropAndSaveFace(image, selection.face!);

      context.read<FaceAuthBloc>().add(
        RegisterFaceEvent(
          name: name,
          faceImagePath: cropped.path,
        ),
      );
    } catch (_) {
      _set('Registration failed', _RegisterStatus.error);
      _busy = false;
    }
  }

  void _set(String msg, _RegisterStatus s) {
    if (!mounted) return;
    setState(() {
      _message = msg;
      _status = s;
    });
  }

  Color get _statusColor {
    switch (_status) {
      case _RegisterStatus.processing:
        return const Color(0xFF2563EB);
      case _RegisterStatus.success:
        return const Color(0xFF16A34A);
      case _RegisterStatus.error:
        return const Color(0xFFDC2626);
      case _RegisterStatus.info:
        return const Color(0xFFD97706);
      case _RegisterStatus.idle:
      default:
        return const Color(0xFF111827);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: BlocListener<FaceAuthBloc, FaceAuthState>(
        listener: (context, state) async {
          if (state is FaceRegistered) {
            _set('Registration successful', _RegisterStatus.success);
            await Future.delayed(const Duration(seconds: 2));
            if (mounted) Navigator.pop(context);
          }

          if (state is FaceAuthFailed) {
            _set(state.message, _RegisterStatus.error);
            _busy = false;
          }
        },
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 32),

              // 🔹 System title
              const Text(
                'Register Face',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.4,
                ),
              ),

              const SizedBox(height: 24),

              // 📝 Name input (system style)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: TextField(
                  controller: _nameController,
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    labelText: 'Full Name',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide:
                      BorderSide(color: Colors.grey.shade300),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide:
                      BorderSide(color: Colors.grey.shade300),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // 📷 Camera frame (same as Verify)
              Expanded(
                child: Center(
                  child: Container(
                    width: 280,
                    height: 280,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.grey.shade300,
                        width: 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: CameraPreviewWidget(
                      autoCapture: true,
                      onImageCaptured: _processFrame,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // 🔹 Status pill (same style)
              AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: _statusColor,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  _message,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
