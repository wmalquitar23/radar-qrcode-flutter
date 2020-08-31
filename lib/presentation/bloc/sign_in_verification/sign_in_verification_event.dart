part of 'sign_in_verification_bloc.dart';

abstract class SignInVerificationEvent extends Equatable {
  const SignInVerificationEvent();

  @override
  List<Object> get props => [];
}

class IsFetching extends SignInVerificationEvent {}

class SignIn extends SignInVerificationEvent {
  const SignIn({this.contactNumber, this.pin});

  final String contactNumber;
  final String pin;
}
