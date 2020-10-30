import 'dart:io';

import 'package:radar_qrcode_flutter/core/utils/app/env_util.dart';
import 'package:radar_qrcode_flutter/core/utils/image/image.utils.dart';
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
    StandardResponse response = await restClient.fileUpload(file);
    await updateUser({"profileImageFileId": response.data['fileId']});
  }

  @override
  Future<Session> fetchUserInfo() async {
    StandardResponse userInfoResponse = await restClient.getProfileInfo();
    Session session = await getCurrentSession();
    userInfoResponse.data['profileImageFileId'] =
        await parseImage(userInfoResponse.data['profileImageFileId']);

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
    await updateUser({"pin": newPin});
  }

  @override
  Future<void> uploadVerificationId(File file) async {
    StandardResponse response = await restClient.fileUpload(file);
    await restClient.submitRequirements({"fileId": response.data['fileId']});
  }
}
