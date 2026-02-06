import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

class LivenessChecker {
  /// Returns true if the face is considered live
  static bool isLive(Face face) {
    final leftEye = face.leftEyeOpenProbability;
    final rightEye = face.rightEyeOpenProbability;
    final isBlinking =
        (leftEye != null && leftEye < 0.4) ||
            (rightEye != null && rightEye < 0.4);

    final yaw = face.headEulerAngleY;
    final isHeadTurned =
        yaw != null && yaw.abs() > 10;

    return isBlinking || isHeadTurned;
  }
}
