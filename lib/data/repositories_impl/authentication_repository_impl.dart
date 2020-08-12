import 'package:radar_qrcode_flutter/data/local_db/session_db.dart';
import 'package:radar_qrcode_flutter/data/models/session_model.dart';
import 'package:radar_qrcode_flutter/data/models/standard_response.dart';
import 'package:radar_qrcode_flutter/data/sources/data/rest_client.dart';
import 'package:radar_qrcode_flutter/domain/repositories/authentication_repository.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class AuthenticationRepositoryImpl extends AuthenticationRepository {
  Database db;
  RestClient restClient;
  SessionDb sessionDb;

  AuthenticationRepositoryImpl(this.db, this.restClient) {
    restClient = this.restClient;
    sessionDb = SessionDb(db);
  }

  @override
  Future<void> logout() async {
    await databaseFactoryIo.deleteDatabase(db.path);
    await sessionDb?.deleteAll();
  }

  @override
  Future<Session> getCurrentSession() async {
    return sessionDb.getCurrentSession();
  }

  @override
  Future<Session> register(String firstName, String lastName, String pin,
      String contactNumber, String address) async {
    StandardResponse userInfoResponse = await restClient.register(
        firstName, lastName, pin, contactNumber, address);

    await sessionDb.save({
      "user": userInfoResponse.data.user,
      "token": userInfoResponse.data.token
    });
    return sessionDb.getCurrentSession();
  }
}
