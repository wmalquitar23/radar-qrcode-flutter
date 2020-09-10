part of 'establishment_bloc.dart';

abstract class EstablishmentEvent extends Equatable {
  const EstablishmentEvent();

  @override
  List<Object> get props => [];
}

class GetUserData extends EstablishmentEvent {
  final User user;
  final List<CheckIn> checkIn;

  GetUserData({
    this.user,
    this.checkIn,
  });

  @override
  List<Object> get props => [user];
}

class EstablishmentOnLoad extends EstablishmentEvent {}

class ProfileImageOnUpload extends EstablishmentEvent {
  final File image;

  ProfileImageOnUpload(this.image);

  @override
  List<Object> get props => [image];
}

class OnSyncDataPressed extends EstablishmentEvent {}

class OnRefresh extends EstablishmentEvent {}