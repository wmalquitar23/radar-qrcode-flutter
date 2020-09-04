part of 'establishment_basic_information_bloc.dart';

abstract class EstablishmentBasicInformationState extends Equatable {
  const EstablishmentBasicInformationState();

  @override
  List<Object> get props => [];
}

class EstablishmentBasicInformationInitial
    extends EstablishmentBasicInformationState {}

class RegisterDone extends EstablishmentBasicInformationState {}

class RegisterProgress extends EstablishmentBasicInformationState {}

class RegisterFailure extends EstablishmentBasicInformationState {
  final String error;

  const RegisterFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => '{ $error }';
}

// ==============================================================

class ContactNumberState extends EstablishmentBasicInformationState {
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
