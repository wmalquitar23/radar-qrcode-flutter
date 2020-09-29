import 'dart:io';

import 'package:radar_qrcode_flutter/core/utils/app/env_util.dart';
import 'package:radar_qrcode_flutter/data/local_db/session_db.dart';
import 'package:radar_qrcode_flutter/data/models/session_model.dart';
import 'package:radar_qrcode_flutter/data/models/standard_response.dart';
import 'package:radar_qrcode_flutter/data/sources/data/rest_client.dart';
import 'package:radar_qrcode_flutter/domain/repositories/profile_repository.dart';
import 'package:sembast/sembast.dart';
import 'package:intl/intl.dart';

class ProfileRepositoryImpl extends ProfileRepository {
  Database db;
  RestClient restClient;
  SessionDb sessionDb;

  DateFormat birthdayFormatter = DateFormat("yyyy-MM-dd");

  ProfileRepositoryImpl(this.db, this.restClient) {
    restClient = this.restClient;
    sessionDb = SessionDb(db);
  }

  @override
  Future<void> uploadProfileImage(File file) async {
    Map<String, String> env = await loadEnvFile();
    StandardResponse response = await restClient.fileUpload(file);
    await updateUser(
        {"profileImageUrl": env['API_URL'] + response.data['url']});
  }

  @override
  Future<Session> fetchUserInfo() async {
    StandardResponse userInfoResponse = await restClient.getProfileInfo();
    Session session = await getCurrentSession();

    Map<String, String> env = await loadEnvFile();
    if (userInfoResponse.data['profileImageUrl']
        .contains("54.179.150.142:3000")) {
      userInfoResponse.data['profileImageUrl'] = userInfoResponse
          .data['profileImageUrl']
          .replaceAll('54.179.150.142', env['HOST_URL']);
    }
    await sessionDb
        .save({"token": session.token, "user": userInfoResponse.data});
    return await getCurrentSession();
  }

  @override
  Future<Session> getCurrentSession() async {
    return sessionDb.getCurrentSession();
  }

  @override
  Future<void> updateUser(dynamic data) async {
    Session session = await getCurrentSession();
    await restClient.updateUser(data, session.user.id);
  }

  Future<void> changePin(String oldPin, String newPin) async {
    Session session = await getCurrentSession();
    await restClient.changePin(oldPin, newPin, session.user.id);
  }

  @override
  Future<void> uploadVerificationId(File file) async {
    Map<String, String> env = await loadEnvFile();
    StandardResponse response = await restClient.fileUpload(file);
    Session session = await getCurrentSession();
    await restClient.submitRequirements({
      "userId": session.user.id,
      "fileUrl": env['API_URL'] + response.data['url']
    });
  }
}
