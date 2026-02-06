import 'dart:io';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

class FaceDetectorService {
  static final FaceDetector _detector = FaceDetector(
    options: FaceDetectorOptions(
      performanceMode: FaceDetectorMode.accurate,
      enableLandmarks: true,
      enableClassification: true, 
      enableContours: false,
    )

  );

  static Future<List<Face>> detectFaces(File image) async {
    final inputImage = InputImage.fromFile(image);
    return await _detector.processImage(inputImage);
  }

  static void dispose() {
    _detector.close();
  }
}
