part of 'individual_bloc.dart';

abstract class IndividualEvent extends Equatable {
  const IndividualEvent();

  @override
  List<Object> get props => [];
}

class GetUserData extends IndividualEvent {
  final User user;

  GetUserData({this.user});

  @override
  List<Object> get props => [user];
}

class IndividualOnLoad extends IndividualEvent {}

class OnRefresh extends IndividualEvent {}
