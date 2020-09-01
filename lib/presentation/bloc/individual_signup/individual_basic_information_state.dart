part of 'individual_basic_information_bloc.dart';

abstract class IndividualBasicInformationState extends Equatable {
  const IndividualBasicInformationState();

  @override
  List<Object> get props => [];
}

class IndividualBasicInformationInitial
    extends IndividualBasicInformationState {}

class RegisterDone extends IndividualBasicInformationState {}

class RegisterProgress extends IndividualBasicInformationState {}

class RegisterFailure extends IndividualBasicInformationState {
  final String error;

  const RegisterFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => '{ $error }';
}

// ==============================================================

class ContactNumberState extends IndividualBasicInformationState {
  const ContactNumberState();
}

class ContactNumberIsValid extends ContactNumberState {}

class ContactNumberIsInvalid extends ContactNumberState {
  final String message;
  final int invalidType;

  const ContactNumberIsInvalid({
    @required this.message,
    @required this.invalidType,
  });

  @override
  List<Object> get props => [message, invalidType];
}

class ContactNumberValidationInProgress extends ContactNumberState {}

class ContactNumberValidationFailure extends ContactNumberState {
  final String error;

  const ContactNumberValidationFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => '{ $error }';
}
