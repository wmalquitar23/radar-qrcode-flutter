part of 'sign_in_verification_bloc.dart';

abstract class SignInVerificationState extends Equatable {
  const SignInVerificationState();

  @override
  List<Object> get props => [];
}

class SignInVerificationInitial extends SignInVerificationState {}

class ButtonLoading extends SignInVerificationState {}
