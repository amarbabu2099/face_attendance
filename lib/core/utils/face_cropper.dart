import 'dart:io';
import 'dart:typed_data';
import 'package:image/image.dart' as img;
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

class FaceCropper {
  static Future<File> cropAndSaveFace(
      File originalImage,
      Face face,
      ) async {
    final bytes = originalImage.readAsBytesSync();
    final original = img.decodeImage(bytes)!;

    final rect = face.boundingBox;

    final cropped = img.copyCrop(
      original,
      x: rect.left.toInt(),
      y: rect.top.toInt(),
      width: rect.width.toInt(),
      height: rect.height.toInt(),
    );

    final dir = await getApplicationDocumentsDirectory();
    final filePath = p.join(
      dir.path,
      'face_${DateTime.now().millisecondsSinceEpoch}.jpg',
    );

    final file = File(filePath)
      ..writeAsBytesSync(img.encodeJpg(cropped));

    return file;
  }
}
