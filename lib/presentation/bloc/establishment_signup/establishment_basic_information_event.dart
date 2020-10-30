part of 'establishment_basic_information_bloc.dart';

abstract class EstablishmentBasicInformationEvent extends Equatable {
  const EstablishmentBasicInformationEvent();

  @override
  List<Object> get props => [];
}

class RegisterPressed extends EstablishmentBasicInformationEvent {
  final String establishmentName;
  final String pin;
  final String contactNumber;
  final UserAddress userAddress;
  final String email;

  RegisterPressed({
    @required this.establishmentName,
    @required this.email,
    @required this.pin,
    @required this.contactNumber,
    this.userAddress,
  });
}

class ValidateContactNumber extends EstablishmentBasicInformationEvent {
  final String contactNumber;

  ValidateContactNumber({@required this.contactNumber});
}
