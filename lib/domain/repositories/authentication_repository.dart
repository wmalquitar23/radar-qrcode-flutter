import 'package:radar_qrcode_flutter/core/enums/enums.dart';
import 'package:radar_qrcode_flutter/data/models/address/user_address_model.dart';
import 'package:radar_qrcode_flutter/data/models/session_model.dart';

abstract class AuthenticationRepository {
  Future<void> logout();

  Future<Session> getCurrentSession();

  Stream<Session> listenForSession();

  Future<void> registerIndividual(
    String firstName,
    String lastName,
    String middleName,
    String pin,
    String contactNumber,
    UserAddress address,
    DateTime birthdate,
    Gender gender,
  );

  Future<void> registerEstablishment(
    String establishmentName,
    String pin,
    String contactNumber,
    UserAddress address,
  );

  Future<dynamic> getRegisterQueueData();

  Future<void> verifyOtp(String otp);

  Future<void> signIn(String contactNumber, String pin);

  Future<bool> verifyMobileNumber(String mobileNumber);

  Future<void> resendOTP(String mobileNumber);
}
