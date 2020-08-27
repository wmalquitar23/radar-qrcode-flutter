import 'package:radar_qrcode_flutter/core/enums/enums.dart';
import 'package:radar_qrcode_flutter/domain/repositories/authentication_repository.dart';

class RegisterIndividualUseCase {
  final AuthenticationRepository repository;

  RegisterIndividualUseCase(this.repository);

  Future<void> execute(
    String firstName,
    String lastName,
    String middleName,
    String pin,
    String contactNumber,
    String address,
    DateTime birthDate,
    Gender gender,
  ) {
    return repository.registerIndividual(
      firstName,
      lastName,
      middleName,
      pin,
      contactNumber,
      address,
      birthDate,
      gender,
    );
  }
}
