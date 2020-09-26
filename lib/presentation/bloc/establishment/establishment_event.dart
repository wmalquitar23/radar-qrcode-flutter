part of 'establishment_bloc.dart';

abstract class EstablishmentEvent extends Equatable {
  const EstablishmentEvent();

  @override
  List<Object> get props => [];
}

class GetUserData extends EstablishmentEvent {
  final List<CheckIn> checkIn;
  final List<CheckIn> totalCheckin;

  GetUserData({
    this.checkIn,
    this.totalCheckin,
  });

  @override
  List<Object> get props => [checkIn, totalCheckin];
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
