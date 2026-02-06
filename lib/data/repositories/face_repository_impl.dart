import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:image/image.dart' as img;

import '../../core/db/app_database.dart';
import '../../domain/entities/face_user.dart' as domain;
import '../../domain/entities/attendance.dart';
import '../../domain/exceptions/attendance_exceptions.dart';
import '../../domain/repositories/face_repository.dart';

import '../../core/utils/face_embedder.dart';
import '../../core/utils/embedding_matcher.dart';

import '../datasources/face_local_datasource.dart';
import '../models/face_user_model.dart';
import '../models/attendance_model.dart';

class FaceRepositoryImpl implements FaceRepository {
  final FaceLocalDatasource local;

  FaceRepositoryImpl(this.local);

  @override
  Future<void> registerFace({
    required String name,
    required String faceImagePath,
  }) async {
    // 1️⃣ Decode cropped face image
    final image = img.decodeImage(
      File(faceImagePath).readAsBytesSync(),
    );

    if (image == null) {
      throw Exception('Failed to decode face image');
    }

    // 2️⃣ Generate embedding
    final embedding = FaceEmbedder.getEmbedding(image);

    // 3️⃣ Store user + embedding
    await local.insertUser(
      FaceUsersCompanion.insert(
        name: name,
        faceImagePath: faceImagePath,
        embedding: embedding,
      ),
    );
  }

  @override
  Future<domain.FaceUser?> verifyFace(String capturedImagePath) async {
    final users = await local.getAllUsers();

    // 1️⃣ Decode captured face
    final image = img.decodeImage(
      File(capturedImagePath).readAsBytesSync(),
    );

    if (image == null) return null;

    // 2️⃣ Generate embedding for captured face
    final capturedEmbedding = FaceEmbedder.getEmbedding(image);

    // 3️⃣ Compare with stored embeddings (with score logging)
    for (final user in users) {
      final result = EmbeddingMatcher.match(
        capturedEmbedding,
        user.embedding,
        threshold: 0.62, // 🎯 recommended for attendance
      );

      debugPrint(
        'Face match score for ${user.name}: ${result.score}',
      );

      if (result.isMatch) {
        return user.toDomain();
      }
    }

    return null;
  }

  @override
  Future<void> markAttendance(int userId) async {
    final now = DateTime.now();

    final todayStart = DateTime(now.year, now.month, now.day);
    final todayEnd = todayStart.add(const Duration(days: 1));

    final existing = await local.getAttendanceForUserBetween(
      userId,
      todayStart,
      todayEnd,
    );

    if (existing.isNotEmpty) {
      throw AttendanceAlreadyMarkedException();
    }

    await local.insertAttendance(userId);
  }


  @override
  Future<List<Attendance>> getAttendance() async {
    final records = await local.getAttendance();
    return records.map((e) => e.toDomain()).toList();
  }
}
