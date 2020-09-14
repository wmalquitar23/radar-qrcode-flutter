part of 'individual_bloc.dart';

abstract class IndividualEvent extends Equatable {
  const IndividualEvent();

  @override
  List<Object> get props => [];
}

class GetUserData extends IndividualEvent {}

class IndividualOnLoad extends IndividualEvent {}

class OnRefresh extends IndividualEvent {}
