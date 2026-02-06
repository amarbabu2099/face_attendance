import '../entities/face_user.dart';
import '../repositories/face_repository.dart';

class VerifyFaceUseCase {
  final FaceRepository repository;

  VerifyFaceUseCase(this.repository);

  Future<FaceUser?> call(String capturedImagePath) {
    return repository.verifyFace(capturedImagePath);
  }
}
