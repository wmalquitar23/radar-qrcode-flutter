part of 'change_contact_number_bloc.dart';

abstract class ChangeContactNumberEvent extends Equatable {
  const ChangeContactNumberEvent();

  @override
  List<Object> get props => [];
}

class ContinueButtonPressed extends ChangeContactNumberEvent {
  final String firstName;
  final String middleName;
  final String lastName;
  final String suffix;
  final DateTime birthDate;
  final Gender gender;
  final String pin;
  final String contactNumber;
  final UserAddress address;

  ContinueButtonPressed({
    this.firstName,
    this.middleName,
    this.lastName,
    this.suffix,
    this.birthDate,
    this.gender,
    this.pin,
    this.contactNumber,
    this.address,
  });
}

class ValidateContactNumber extends ChangeContactNumberEvent {
  final String contactNumber;

  ValidateContactNumber({@required this.contactNumber});
}
