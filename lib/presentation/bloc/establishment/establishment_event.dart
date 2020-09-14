part of 'establishment_bloc.dart';

abstract class EstablishmentEvent extends Equatable {
  const EstablishmentEvent();

  @override
  List<Object> get props => [];
}

class GetUserData extends EstablishmentEvent {
  final List<CheckIn> checkIn;

  GetUserData({
    this.checkIn,
  });

  @override
  List<Object> get props => [checkIn];
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
