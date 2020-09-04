import 'package:meta/meta.dart';
import 'package:radar_qrcode_flutter/domain/repositories/authentication_repository.dart';

class RegisterEstablishmentUseCase {
  final AuthenticationRepository repository;

  RegisterEstablishmentUseCase(this.repository);

  Future<void> execute({
    @required String establishmentName,
    @required String pin,
    @required String contactNumber,
    @required String address,
  }) {
    return repository.registerEstablishment(
      establishmentName,
      pin,
      contactNumber,
      address,
    );
  }
}
