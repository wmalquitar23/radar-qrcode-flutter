part of 'verification_bloc.dart';

abstract class VerificationEvent extends Equatable {
  const VerificationEvent();

  @override
  List<Object> get props => [];
}

class OnContinueButtonPressed extends VerificationEvent {
  final String otp;

  OnContinueButtonPressed({this.otp});
}