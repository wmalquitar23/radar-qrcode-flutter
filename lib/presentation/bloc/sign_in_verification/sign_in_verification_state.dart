part of 'sign_in_verification_bloc.dart';

abstract class SignInVerificationState extends Equatable {
  const SignInVerificationState();

  @override
  List<Object> get props => [];
}

class SignInVerificationInitial extends SignInVerificationState {}

class ButtonLoading extends SignInVerificationState {}

class SignInSuccess extends SignInVerificationState {
  final String route;

  SignInSuccess({this.route});

  @override
  List<Object> get props => [route];
}

class SignInFailure extends SignInVerificationState {
  final String error;

  const SignInFailure({this.error});

  @override
  List<Object> get props => [error];
}
