import 'package:radar_qrcode_flutter/data/models/session_model.dart';

abstract class AuthenticationRepository {
  Future<void> logout();

  Future<Session> getCurrentSession();

  Future<Session> register(String firstName, String lastName, String pin,
      String contactNumber, String address);
}
