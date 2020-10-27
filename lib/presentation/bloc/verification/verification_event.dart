part of 'verification_bloc.dart';

abstract class VerificationEvent extends Equatable {
  const VerificationEvent();

  @override
  List<Object> get props => [];
}

class OnContinueButtonPressed extends VerificationEvent {
  final String otp;
  final String contactNumber;

  OnContinueButtonPressed({@required this.otp, @required this.contactNumber});
}

class OnResendPressed extends VerificationEvent {
  final String mobileNumber;
  OnResendPressed({@required this.mobileNumber});
}
