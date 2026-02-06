import '../../domain/entities/face_user.dart' as domain;
import '../../core/db/app_database.dart' as db;

/// Mapper from Drift FaceUser -> Domain FaceUser
extension FaceUserMapper on db.FaceUser {
  domain.FaceUser toDomain() {
    return domain.FaceUser(
      id: id,
      name: name,
      faceImagePath: faceImagePath,
      embedding: embedding, // ✅ NEW
      createdAt: createdAt,
    );
  }
}
