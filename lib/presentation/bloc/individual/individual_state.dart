part of 'individual_bloc.dart';

abstract class IndividualState extends Equatable {
  const IndividualState();

  @override
  List<Object> get props => [];
}

class IndividualInitial extends IndividualState {}

class IndividualProgress extends IndividualState {}

class IndividualGetUserSuccess extends IndividualState {
  final User user;

  const IndividualGetUserSuccess({this.user});

  @override
  List<Object> get props => [user];
}

class IndividualFailure extends IndividualState {}
