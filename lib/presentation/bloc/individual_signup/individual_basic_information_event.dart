part of 'individual_basic_information_bloc.dart';

abstract class IndividualBasicInformationEvent extends Equatable {
  const IndividualBasicInformationEvent();

  @override
  List<Object> get props => [];
}

class RegisterPressed extends IndividualBasicInformationEvent {
  final String firstName;
  final String middleName;
  final String lastName;
  final String suffix;
  final DateTime birthDate;
  final Gender gender;
  final String pin;
  final String contactNumber;
  final String email;
  final UserAddress userAddress;

  RegisterPressed({
    this.firstName,
    this.middleName,
    this.lastName,
    this.suffix,
    this.birthDate,
    this.gender,
    this.pin,
    this.contactNumber,
    this.userAddress,
    this.email,
  });
}

class ValidateContactNumber extends IndividualBasicInformationEvent {
  final String contactNumber;

  ValidateContactNumber({@required this.contactNumber});
}
