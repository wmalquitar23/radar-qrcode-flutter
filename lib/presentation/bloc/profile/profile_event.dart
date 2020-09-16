part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class GetUserData extends ProfileEvent {
}

class ProfileOnLoad extends ProfileEvent {}

class ProfileImageOnUpload extends ProfileEvent {
  final File image;

  ProfileImageOnUpload(this.image);

  @override
  List<Object> get props => [image];
}
