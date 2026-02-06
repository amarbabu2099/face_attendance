import '../repositories/face_repository.dart';

class RegisterFaceUseCase {
  final FaceRepository repository;

  RegisterFaceUseCase(this.repository);

  Future<void> call({
    required String name,
    required String faceImagePath,
  }) {
    return repository.registerFace(
      name: name,
      faceImagePath: faceImagePath,
    );
  }
}
