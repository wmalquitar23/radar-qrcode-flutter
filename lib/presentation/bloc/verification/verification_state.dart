part of 'verification_bloc.dart';

abstract class VerificationState extends Equatable {
  const VerificationState();

  @override
  List<Object> get props => [];
}

class VerificationInitial extends VerificationState {}

class VerificationProgress extends VerificationState {}

class VerificationFailure extends VerificationState {
  final String error;

  const VerificationFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => '{ $error }';
}

class VerificationSuccess extends VerificationState {}

class ResendReady extends VerificationState {}

class ResendOnCoolDown extends VerificationState {}
