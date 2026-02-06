import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/exceptions/attendance_exceptions.dart';
import '../../domain/usecases/register_face_usecase.dart';
import '../../domain/usecases/verify_face_usecase.dart';
import '../../domain/usecases/mark_attendance_usecase.dart';
import '../../domain/repositories/face_repository.dart';

import 'face_auth_event.dart';
import 'face_auth_state.dart';

class FaceAuthBloc extends Bloc<FaceAuthEvent, FaceAuthState> {
  final RegisterFaceUseCase registerFace;
  final VerifyFaceUseCase verifyFace;
  final MarkAttendanceUseCase markAttendance;

  FaceAuthBloc({
    required this.registerFace,
    required this.verifyFace,
    required this.markAttendance,
  }) : super(FaceAuthInitial()) {
    on<RegisterFaceEvent>(_onRegisterFace);
    on<VerifyFaceEvent>(_onVerifyFace);
  }

  Future<void> _onRegisterFace(
      RegisterFaceEvent event,
      Emitter<FaceAuthState> emit,
      ) async {
    emit(FaceAuthLoading());

    try {
      await registerFace(
        name: event.name,
        faceImagePath: event.faceImagePath,
      );

      emit(FaceRegistered());
    } catch (_) {
      emit(const FaceAuthFailed('Failed to register face'));
    }
  }

  Future<void> _onVerifyFace(
      VerifyFaceEvent event,
      Emitter<FaceAuthState> emit,
      ) async {
    emit(FaceAuthLoading());

    try {
      final user = await verifyFace(event.capturedImagePath);

      if (user == null) {
        emit(const FaceAuthFailed('Face not recognized'));
        return;
      }

      await markAttendance(user.id);
      emit(FaceVerified(user));
    } on AttendanceAlreadyMarkedException {
      emit(const FaceAuthFailed(
        'Attendance already marked today',
      ));
    } catch (_) {
      emit(const FaceAuthFailed('Verification failed'));
    }
  }
}
