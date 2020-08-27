import 'package:radar_qrcode_flutter/core/enums/enums.dart';
import 'package:radar_qrcode_flutter/data/local_db/queue/register_queue_db.dart';
import 'package:radar_qrcode_flutter/data/local_db/session_db.dart';
import 'package:radar_qrcode_flutter/data/mappers/user_mapper.dart';
import 'package:radar_qrcode_flutter/data/models/session_model.dart';
import 'package:radar_qrcode_flutter/data/models/standard_response.dart';
// import 'package:radar_qrcode_flutter/data/models/standard_response.dart';
import 'package:radar_qrcode_flutter/data/sources/data/rest_client.dart';
import 'package:radar_qrcode_flutter/domain/repositories/authentication_repository.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:intl/intl.dart';

class AuthenticationRepositoryImpl extends AuthenticationRepository {
  Database db;
  RestClient restClient;
  SessionDb sessionDb;
  RegisterQueueDb registerQueueDb;
  UserMapper userMapper;

  DateFormat birthdayFormatter = DateFormat("yyyy-MM-dd");

  AuthenticationRepositoryImpl(this.db, this.restClient) {
    restClient = this.restClient;
    sessionDb = SessionDb(db);
    registerQueueDb = RegisterQueueDb(db);

    userMapper = UserMapper();
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
  Future<void> registerIndividual(
      String firstName,
      String lastName,
      String middleName,
      String pin,
      String contactNumber,
      String address,
      DateTime birthdate,
      Gender gender) async {
    registerQueueDb.save(
      {
        "firstname": firstName,
        "lastname": lastName,
        "pin": pin,
        "birthDate": birthdayFormatter.format(birthdate),
        "gender": gender == Gender.male ? "male" : "female",
        "contactNumber": contactNumber,
        "address": {"name": address},
      },
    );
    await restClient.otpMobileNumber(contactNumber);
  }

  @override
  Future<dynamic> getRegisterQueueData() async {
    return await registerQueueDb.getRegistrationData();
  }

  Future<void> verifyOtp(String otp) async {
    await restClient.verifyOtp(otp);
    dynamic registrationData = await getRegisterQueueData();
    StandardResponse userInfoResponse =
        await restClient.registerIndividual(registrationData);

    await sessionDb.save({
      "user": userInfoResponse.data['individual'],
      "token": userInfoResponse.data['token']
    });
    return await sessionDb.getCurrentSession();
  }
}
