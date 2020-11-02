import 'package:radar_qrcode_flutter/core/enums/enums.dart';
import 'package:radar_qrcode_flutter/data/models/address/user_address_model.dart';
import 'package:radar_qrcode_flutter/domain/repositories/authentication_repository.dart';

class RegisterIndividualUseCase {
  final AuthenticationRepository repository;

  RegisterIndividualUseCase(this.repository);

  Future<void> execute(
    String firstName,
    String lastName,
    String middleName,
    String suffix,
    String pin,
    String contactNumber,
    UserAddress userAddress,
    DateTime birthDate,
    Gender gender,
    String email,
  ) {
    return repository.registerIndividual(
      firstName,
      lastName,
      middleName,
      suffix,
      pin,
      contactNumber,
      userAddress,
      birthDate,
      gender,
      email,
    );
  }
}
