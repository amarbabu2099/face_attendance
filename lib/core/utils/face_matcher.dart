import 'dart:io';
import 'dart:typed_data';
import 'package:image/image.dart' as img;

class FaceMatcher {
  static bool isMatch(String path1, String path2) {
    final img1 = img.decodeImage(File(path1).readAsBytesSync());
    final img2 = img.decodeImage(File(path2).readAsBytesSync());

    if (img1 == null || img2 == null) return false;

    final resized1 = img.copyResize(img1, width: 100, height: 100);
    final resized2 = img.copyResize(img2, width: 100, height: 100);

    // ✅ Correct way in image v4+
    final Uint8List bytes1 = resized1.getBytes();
    final Uint8List bytes2 = resized2.getBytes();

    double diff = 0;

    final len = bytes1.length;
    for (int i = 0; i < len; i++) {
      diff += (bytes1[i] - bytes2[i]).abs();
    }

    // Threshold (tunable)
    return diff < 1_000_000;
  }
}
