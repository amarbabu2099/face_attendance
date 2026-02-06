import '../entities/face_user.dart';
import '../entities/attendance.dart';

abstract class FaceRepository {
  /// Register a new user with face image path
  Future<void> registerFace({
    required String name,
    required String faceImagePath,
  });

  /// Verify captured face against stored faces
  Future<FaceUser?> verifyFace(String capturedImagePath);

  /// Mark attendance
  Future<void> markAttendance(int userId);

  /// Get attendance history
  Future<List<Attendance>> getAttendance();
}
