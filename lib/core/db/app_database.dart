import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'converters/double_list_converter.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    FaceUsers,
    AttendanceTable,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  // ✅ BUMPED because we added `embedding` column
  @override
  int get schemaVersion => 2;

  // ✅ Optional but recommended for future safety
  @override
  MigrationStrategy get migration => MigrationStrategy(
    onUpgrade: (migrator, from, to) async {
      if (from < 2) {
        await migrator.addColumn(faceUsers, faceUsers.embedding);
      }
    },
  );
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'face_attendance.sqlite'));
    return NativeDatabase(file);
  });
}

// ====================
// FACE USERS TABLE
// ====================
class FaceUsers extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text()();

  /// Local path to cropped face image
  TextColumn get faceImagePath => text()();

  /// Face embedding (192 floats, JSON-encoded)
  TextColumn get embedding =>
      text().map(const DoubleListConverter())();

  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();
}

// ====================
// ATTENDANCE TABLE
// ====================
class AttendanceTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get userId =>
      integer().references(FaceUsers, #id)();

  DateTimeColumn get timestamp =>
      dateTime().withDefault(currentDateAndTime)();
}
