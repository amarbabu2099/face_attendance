import '../repositories/face_repository.dart';

class MarkAttendanceUseCase {
  final FaceRepository repository;

  MarkAttendanceUseCase(this.repository);

  Future<void> call(int userId) {
    return repository.markAttendance(userId);
  }
}
