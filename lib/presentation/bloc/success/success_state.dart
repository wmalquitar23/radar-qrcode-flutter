part of 'success_bloc.dart';

abstract class SuccessState extends Equatable {
  const SuccessState();

  @override
  List<Object> get props => [];
}

class SuccessInitial extends SuccessState {}

class GoToRouteState extends SuccessState {
  final String route;

  GoToRouteState({this.route});
}

class VerificationFailure extends SuccessState {
  final String error;

  const VerificationFailure(this.error);

  @override
  List<Object> get props => [error];

  @override
  String toString() => '{ $error }';
}
