import 'package:equatable/equatable.dart';
import '../../domain/entities/face_user.dart';

abstract class FaceAuthState extends Equatable {
  const FaceAuthState();

  @override
  List<Object?> get props => [];
}

class FaceAuthInitial extends FaceAuthState {}

class FaceAuthLoading extends FaceAuthState {}

class FaceRegistered extends FaceAuthState {}

class FaceVerified extends FaceAuthState {
  final FaceUser user;

  const FaceVerified(this.user);

  @override
  List<Object?> get props => [user];
}

class FaceAuthFailed extends FaceAuthState {
  final String message;

  const FaceAuthFailed(this.message);

  @override
  List<Object?> get props => [message];
}
