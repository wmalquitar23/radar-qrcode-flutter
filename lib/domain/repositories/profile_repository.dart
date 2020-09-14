import 'dart:io';

import 'package:radar_qrcode_flutter/data/models/session_model.dart';

abstract class ProfileRepository {
  Future<void> uploadProfileImage(File file);

  Future<Session> fetchUserInfo();

  Future<Session> getCurrentSession();

  Future<void> updateUser(dynamic data);

  Future<void> changePin(String oldPin, String newPin);

  Future<bool> uploadVerificationId(File file);
}
