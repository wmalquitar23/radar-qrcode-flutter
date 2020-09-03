import 'dart:io';

import 'package:radar_qrcode_flutter/data/models/session_model.dart';

abstract class ProfileRepository {
  Future<void> uploadProfileImage(File file);

  Future<Session> fetchUserInfo();

  Future<Session> getCurrentSession();
}