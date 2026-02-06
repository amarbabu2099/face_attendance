import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

class FaceSelectionResult {
  final Face? face;
  final String? error;

  FaceSelectionResult({
    this.face,
    this.error,
  });

  bool get isValid => face != null;
}

class FaceSelectionHelper {
  static FaceSelectionResult selectSingleFace(
      List<Face> faces,
      ) {
    if (faces.isEmpty) {
      return FaceSelectionResult(
        error: 'No face detected',
      );
    }

    if (faces.length > 1) {
      return FaceSelectionResult(
        error: 'Multiple faces detected. Please be alone.',
      );
    }

    return FaceSelectionResult(face: faces.first);
  }
}
