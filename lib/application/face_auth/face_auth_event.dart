import 'package:equatable/equatable.dart';

abstract class FaceAuthEvent extends Equatable {
  const FaceAuthEvent();

  @override
  List<Object?> get props => [];
}

class RegisterFaceEvent extends FaceAuthEvent {
  final String name;
  final String faceImagePath;

  const RegisterFaceEvent({
    required this.name,
    required this.faceImagePath,
  });

  @override
  List<Object?> get props => [name, faceImagePath];
}

class VerifyFaceEvent extends FaceAuthEvent {
  final String capturedImagePath;

  const VerifyFaceEvent(this.capturedImagePath);

  @override
  List<Object?> get props => [capturedImagePath];
}
