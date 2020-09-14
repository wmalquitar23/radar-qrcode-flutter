import 'package:radar_qrcode_flutter/domain/repositories/authentication_repository.dart';

class ResendOTPUseCase {
  final AuthenticationRepository repository;

  ResendOTPUseCase(this.repository);

  Future<void> execute(String mobileNumber) async {
    return await repository.resendOTP(mobileNumber);
  }
}
