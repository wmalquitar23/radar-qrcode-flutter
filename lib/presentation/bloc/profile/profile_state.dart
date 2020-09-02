part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileGetDataLoading extends ProfileState {}

class ProfileGetDataSuccess extends ProfileState {
  final User user;

  const ProfileGetDataSuccess({this.user});

  @override
  List<Object> get props => [user];
}

class ProfileGetDataFailure extends ProfileState {}

class ProfileUploadingImageLoading extends ProfileState {}

class ProfileUploadingImageSuccess extends ProfileState {}

class ProfileUploadingImageFailure extends ProfileState {}
