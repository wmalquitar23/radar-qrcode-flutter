part of 'sign_in_verification_bloc.dart';

abstract class SignInVerificationEvent extends Equatable {
  const SignInVerificationEvent();

  @override
  List<Object> get props => [];
}

class IsFetching extends SignInVerificationEvent {}

class SignIn extends SignInVerificationEvent {
  final String contactNumber;
  final String pin;

  const SignIn({
    this.contactNumber,
    this.pin,
  });

  @override
  List<Object> get props => [contactNumber, pin];
}
