import 'dart:typed_data';
import 'package:image/image.dart' as img;
import 'package:tflite_flutter/tflite_flutter.dart';

class FaceEmbedder {
  static late Interpreter _interpreter;
  static bool _initialized = false;

  static Future<void> init() async {
    if (_initialized) return;

    _interpreter = await Interpreter.fromAsset(
      'assets/models/mobilefacenet.tflite',
      options: InterpreterOptions()..threads = 2,
    );


    _initialized = true;
  }

  static List<double> getEmbedding(img.Image image) {
    final resized = img.copyResize(image, width: 112, height: 112);

    final input = Float32List(1 * 112 * 112 * 3);
    int index = 0;

    for (int y = 0; y < 112; y++) {
      for (int x = 0; x < 112; x++) {
        final pixel = resized.getPixel(x, y);

        // ✅ image v4 correct access
        input[index++] = (pixel.r - 128) / 128;
        input[index++] = (pixel.g - 128) / 128;
        input[index++] = (pixel.b - 128) / 128;
      }
    }

    final output = List.filled(192, 0.0).reshape([1, 192]);

    _interpreter.run(
      input.reshape([1, 112, 112, 3]),
      output,
    );

    return List<double>.from(output[0]);
  }
}
