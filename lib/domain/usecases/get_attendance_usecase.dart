import '../entities/attendance.dart';
import '../repositories/face_repository.dart';

class GetAttendanceUseCase {
  final FaceRepository repository;

  GetAttendanceUseCase(this.repository);

  Future<List<Attendance>> call() {
    return repository.getAttendance();
  }
}
