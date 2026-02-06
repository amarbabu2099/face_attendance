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
import '../../core/utils/system_feedback.dart';
import '../widgets/camera_preview_widget.dart';

class VerifyFaceScreen extends StatefulWidget {
  const VerifyFaceScreen({super.key});

  @override
  State<VerifyFaceScreen> createState() => _VerifyFaceScreenState();
}

enum _VerifyStatus { idle, info, processing, success, error }

class _VerifyFaceScreenState extends State<VerifyFaceScreen> {
  bool _busy = false;
  String _message = 'Position your face inside the frame';
  _VerifyStatus _status = _VerifyStatus.idle;

  Future<void> _handleFrame(File image) async {
    if (_busy) return;
    _busy = true;

    try {
      final faces = await FaceDetectorService.detectFaces(image);
      final selection =
      FaceSelectionHelper.selectSingleFace(faces);

      if (!selection.isValid) {
        _set(selection.error!, _VerifyStatus.info);
        _busy = false;
        return;
      }

      if (!LivenessChecker.isLive(selection.face!)) {
        _set('Blink or turn your head', _VerifyStatus.info);
        _busy = false;
        return;
      }

      _set('Verifying identity…', _VerifyStatus.processing);

      final cropped =
      await FaceCropper.cropAndSaveFace(image, selection.face!);

      context.read<FaceAuthBloc>().add(
        VerifyFaceEvent(cropped.path),
      );
    } catch (_) {
      _set('Verification failed', _VerifyStatus.error);
      _busy = false;
    }
  }

  void _set(String msg, _VerifyStatus s) {
    if (!mounted) return;
    setState(() {
      _message = msg;
      _status = s;
    });
  }

  void _reset() async {
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    setState(() {
      _message = 'Position your face inside the frame';
      _status = _VerifyStatus.idle;
      _busy = false;
    });
  }

  Color get _statusColor {
    switch (_status) {
      case _VerifyStatus.processing:
        return const Color(0xFF2563EB);
      case _VerifyStatus.success:
        return const Color(0xFF16A34A);
      case _VerifyStatus.error:
        return const Color(0xFFDC2626);
      case _VerifyStatus.info:
        return const Color(0xFFD97706);
      case _VerifyStatus.idle:
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
          if (state is FaceVerified) {
            _set(
              'Welcome, ${state.user.name}',
              _VerifyStatus.success,
            );

            await SystemFeedback.success(
              'Welcome ${state.user.name}',
            );

            // ⏱ hard delay before reset
            await Future.delayed(const Duration(seconds: 3));
            _reset();
          }

          if (state is FaceAuthFailed) {
            _set(state.message, _VerifyStatus.error);

            await SystemFeedback.error(
              state.message,
            );

            await Future.delayed(const Duration(seconds: 3));
            _reset();
          }
        },
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 32),

              // 🔹 System title
              const Text(
                'Face Attendance',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.4,
                ),
              ),

              const SizedBox(height: 32),

              // 📷 Camera frame
              Expanded(
                child: Center(
                  child: Container(
                    width: 280,
                    height: 280,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                      border: Border.all(
                        color: Colors.grey.shade300,
                        width: 1.5,
                      ),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: CameraPreviewWidget(
                      autoCapture: true,
                      onImageCaptured: _handleFrame,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // 🔹 Status pill
              AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
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
