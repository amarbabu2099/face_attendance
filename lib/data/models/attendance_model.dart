import '../../domain/entities/attendance.dart';
import '../../core/db/app_database.dart';

extension AttendanceMapper on AttendanceTableData {
  Attendance toDomain() {
    return Attendance(
      id: id,
      userId: userId,
      timestamp: timestamp,
    );
  }
}
