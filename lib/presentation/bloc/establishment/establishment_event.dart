part of 'establishment_bloc.dart';

abstract class EstablishmentEvent extends Equatable {
  const EstablishmentEvent();

  @override
  List<Object> get props => [];
}

class GetUserData extends EstablishmentEvent {
  final User user;

  GetUserData({this.user});

  @override
  List<Object> get props => [user];
}

class EstablishmentOnLoad extends EstablishmentEvent {}
