import 'package:get_it/get_it.dart';

import '../../application/attendance/attendance_cubit.dart';
import '../db/app_database.dart';

import '../../data/datasources/face_local_datasource.dart';
import '../../data/repositories/face_repository_impl.dart';

import '../../domain/repositories/face_repository.dart';
import '../../domain/usecases/register_face_usecase.dart';
import '../../domain/usecases/verify_face_usecase.dart';
import '../../domain/usecases/mark_attendance_usecase.dart';
import '../../domain/usecases/get_attendance_usecase.dart';

import '../../application/face_auth/face_auth_bloc.dart';

final getIt = GetIt.instance;

Future<void> configureDependencies() async {
  // --------------------
  // DATABASE
  // --------------------
  getIt.registerLazySingleton<AppDatabase>(() => AppDatabase());

  // --------------------
  // DATASOURCE
  // --------------------
  getIt.registerLazySingleton<FaceLocalDatasource>(
        () => FaceLocalDatasource(getIt<AppDatabase>()),
  );

  // --------------------
  // REPOSITORY  ✅ THIS WAS MISSING / BROKEN
  // --------------------
  getIt.registerLazySingleton<FaceRepository>(
        () => FaceRepositoryImpl(getIt<FaceLocalDatasource>()),
  );

  // --------------------
  // USE CASES
  // --------------------
  getIt.registerLazySingleton(
        () => RegisterFaceUseCase(getIt<FaceRepository>()),
  );

  getIt.registerLazySingleton(
        () => VerifyFaceUseCase(getIt<FaceRepository>()),
  );

  getIt.registerLazySingleton(
        () => MarkAttendanceUseCase(getIt<FaceRepository>()),
  );

  getIt.registerLazySingleton(
        () => GetAttendanceUseCase(getIt<FaceRepository>()),
  );

  // --------------------
  // BLOC
  // --------------------
  getIt.registerFactory(
        () => FaceAuthBloc(
      registerFace: getIt(),
      verifyFace: getIt(),
      markAttendance: getIt(),
    ),
  );
  getIt.registerFactory(
        () => AttendanceCubit(getIt<GetAttendanceUseCase>()),
  );
}
