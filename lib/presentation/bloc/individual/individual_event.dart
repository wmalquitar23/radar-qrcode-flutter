part of 'individual_bloc.dart';

abstract class IndividualEvent extends Equatable {
  const IndividualEvent();

  @override
  List<Object> get props => [];
}

class GetUserData extends IndividualEvent {
  final List<CheckIn> checkIn;
  final List<CheckIn> totalCheckin;

  GetUserData({
    this.checkIn,
    this.totalCheckin,
  });

  @override
  List<Object> get props => [checkIn, totalCheckin];
}

class IndividualOnLoad extends IndividualEvent {}

class OnRefresh extends IndividualEvent {}

class OnSyncDataPressed extends IndividualEvent {}
