import 'package:radar_qrcode_flutter/domain/repositories/authentication_repository.dart';

class VerifyExistingMobileNumberUseCase {
  final AuthenticationRepository repository;

  VerifyExistingMobileNumberUseCase(this.repository);

  Future<bool> execute(String mobileNumber) async {
    return await repository.verifyMobileNumber(mobileNumber);
  }
}
