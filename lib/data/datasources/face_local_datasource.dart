import 'package:drift/drift.dart';

import '../../core/db/app_database.dart';

class FaceLocalDatasource {
  final AppDatabase db;

  FaceLocalDatasource(this.db);

  // ---------- Face User ----------

  Future<int> insertUser(FaceUsersCompanion user) {
    return db.into(db.faceUsers).insert(user);
  }

  Future<List<FaceUser>> getAllUsers() {
    return db.select(db.faceUsers).get();
  }

  Future<FaceUser?> getUserById(int id) {
    return (db.select(db.faceUsers)
      ..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();
  }

  // ---------- Attendance ----------

  Future<void> insertAttendance(int userId) async {
    await db.into(db.attendanceTable).insert(
      AttendanceTableCompanion.insert(userId: userId),
    );
  }

  Future<List<AttendanceTableData>> getAttendance() {
    return db.select(db.attendanceTable).get();
  }
  Future<List<AttendanceTableData>> getAttendanceForUserBetween(
      int userId,
      DateTime from,
      DateTime to,
      ) {
    return (db.select(db.attendanceTable)
      ..where((tbl) =>
      tbl.userId.equals(userId) &
      tbl.timestamp.isBiggerOrEqualValue(from) &
      tbl.timestamp.isSmallerThanValue(to)))
        .get();
  }

}
