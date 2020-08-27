import 'package:radar_qrcode_flutter/domain/repositories/authentication_repository.dart';

class OtpVerificationUseCase {
  final AuthenticationRepository repository;

  OtpVerificationUseCase(this.repository);

  Future<void> execute(String otp) async {
    return await repository.verifyOtp(otp);
  }
}
