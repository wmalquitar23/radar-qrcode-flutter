part of 'change_contact_number_bloc.dart';

abstract class ChangeContactNumberState extends Equatable {
  const ChangeContactNumberState();

  @override
  List<Object> get props => [];
}

class RegisterDone extends ChangeContactNumberState {}

class RegisterProgress extends ChangeContactNumberState {}

class RegisterFailure extends ChangeContactNumberState {
  final String error;

  const RegisterFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => '{ $error }';
}

class ChangeContactNumberInitial extends ChangeContactNumberState {}

class ContactNumberIsValid extends ChangeContactNumberState {}

class ContactNumberIsInvalid extends ChangeContactNumberState {
  final String message;
  final int invalidType;

  const ContactNumberIsInvalid(
      {@required this.message, @required this.invalidType});

  @override
  List<Object> get props => [message, invalidType];
}

class ContactNumberValidationInProgress extends ChangeContactNumberState {}

class ContactNumberValidationFailure extends ChangeContactNumberState {
  final String error;

  const ContactNumberValidationFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => '{ $error }';
}
