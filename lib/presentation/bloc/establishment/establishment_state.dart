part of 'establishment_bloc.dart';

abstract class EstablishmentState extends Equatable {
  const EstablishmentState();

  @override
  List<Object> get props => [];
}

class EstablishmentInitial extends EstablishmentState {}

class EstablishmentProgress extends EstablishmentState {}

class EstablishmentGetUserSuccess extends EstablishmentState {
  final User user;

  const EstablishmentGetUserSuccess({this.user});

  @override
  List<Object> get props => [user];
}

class EstablishmentFailure extends EstablishmentState {}



class ProfileUploadingImageLoading extends EstablishmentState {}

class ProfileUploadingImageSuccess extends EstablishmentState {}

class ProfileUploadingImageFailure extends EstablishmentState {
  final String error;

  const ProfileUploadingImageFailure({this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => '{ $error }';
}

