import 'dart:io';

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
    await restClient.fileUpload(file);
  }

  @override
  Future<Session> fetchUserInfo() async {
    StandardResponse userInfoResponse = await restClient.getProfileInfo();
    Session session = await getCurrentSession();
    await sessionDb
        .save({"token": session.token, "user": userInfoResponse.data});
    return await getCurrentSession();
  }

  @override
  Future<Session> getCurrentSession() async {
    return sessionDb.getCurrentSession();
  }
}
