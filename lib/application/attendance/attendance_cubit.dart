import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/attendance.dart';
import '../../domain/usecases/get_attendance_usecase.dart';

class AttendanceCubit extends Cubit<List<Attendance>> {
  final GetAttendanceUseCase getAttendance;

  AttendanceCubit(this.getAttendance) : super([]);

  Future<void> loadAttendance() async {
    final data = await getAttendance();
    emit(data);
  }
}
