class FaceUser {
  final int id;
  final String name;
  final String faceImagePath;
  final List<double> embedding;

  final DateTime createdAt;

  FaceUser({
    required this.id,
    required this.name,
    required this.faceImagePath,
    required this.embedding,
    required this.createdAt,
  });
}
