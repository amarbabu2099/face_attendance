import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'application/face_auth/face_auth_bloc.dart';
import 'core/di/injection.dart';
import 'core/utils/face_embedder.dart';
import 'core/utils/system_feedback.dart';
import 'presentation/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ✅ Load face recognition model
  await FaceEmbedder.init();

  // ✅ Configure DI (DB, repos, blocs)
  await configureDependencies();
  await SystemFeedback.init();
  // 🚀 Start UI
  runApp(const FaceAttendanceApp());
}

class FaceAttendanceApp extends StatelessWidget {
  const FaceAttendanceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<FaceAuthBloc>(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Face Attendance',
        theme: ThemeData(useMaterial3: true),
        home: const HomeScreen(),
      ),
    );
  }
}
