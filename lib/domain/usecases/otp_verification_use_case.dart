import 'package:radar_qrcode_flutter/domain/repositories/authentication_repository.dart';

class OtpVerificationUseCase {
  final AuthenticationRepository repository;

  OtpVerificationUseCase(this.repository);

  Future<void> execute(String otp, String contactNumber) async {
    return await repository.verifyOtp(otp, contactNumber);
  }
}
