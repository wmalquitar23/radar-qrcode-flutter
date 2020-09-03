part of 'change_pin_bloc.dart';

abstract class ChangePinState extends Equatable {
  const ChangePinState();

  @override
  List<Object> get props => [];
}

class ChangePinInitial extends ChangePinState {}

class ChangePINLoading extends ChangePinState {}

class ChangePINSuccess extends ChangePinState {}

class ChangePINFailure extends ChangePinState {
  final String error;

  const ChangePINFailure({this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => '{ $error }';
}
