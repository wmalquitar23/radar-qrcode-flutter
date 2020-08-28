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
  final DateTime birthDate;
  final Gender gender;
  final String pin;
  final String contactNumber;
  final String address;

  RegisterPressed({
    this.firstName,
    this.middleName,
    this.lastName,
    this.birthDate,
    this.gender,
    this.pin,
    this.contactNumber,
    this.address,
  });
}
