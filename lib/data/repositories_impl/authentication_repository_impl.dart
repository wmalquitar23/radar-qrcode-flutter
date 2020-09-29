import 'package:radar_qrcode_flutter/core/enums/enums.dart';
import 'package:radar_qrcode_flutter/data/local_db/queue/register_queue_db.dart';
import 'package:radar_qrcode_flutter/data/local_db/session_db.dart';
import 'package:radar_qrcode_flutter/data/mappers/user_address_mapper.dart';
import 'package:radar_qrcode_flutter/data/models/address/user_address_model.dart';
import 'package:radar_qrcode_flutter/data/models/request/register_establishment_request.dart';
import 'package:radar_qrcode_flutter/data/models/request/register_individual_request.dart';
import 'package:radar_qrcode_flutter/data/models/session_model.dart';
import 'package:radar_qrcode_flutter/data/models/standard_response.dart';
import 'package:radar_qrcode_flutter/data/sources/data/rest_client.dart';
import 'package:radar_qrcode_flutter/domain/repositories/authentication_repository.dart';
import 'package:sembast/sembast.dart';
import 'package:intl/intl.dart';

class AuthenticationRepositoryImpl extends AuthenticationRepository {
  Database db;
  RestClient restClient;
  SessionDb sessionDb;
  RegisterQueueDb registerQueueDb;

  DateFormat birthdayFormatter = DateFormat("yyyy-MM-dd");
  UserAddressMapper userAddressMapper = UserAddressMapper();

  AuthenticationRepositoryImpl(this.db, this.restClient) {
    restClient = this.restClient;
    sessionDb = SessionDb(db);
    registerQueueDb = RegisterQueueDb(db);
  }

  @override
  Future<void> logout() async {
    await sessionDb?.deleteAll();
  }

  @override
  Future<Session> getCurrentSession() async {
    return sessionDb.getCurrentSession();
  }

  @override
  Stream<Session> listenForSession() {
    return sessionDb.listenForSession();
  }

  @override
  Future<void> registerIndividual(
      String firstName,
      String lastName,
      String middleName,
      String suffix,
      String pin,
      String contactNumber,
      UserAddress userAddress,
      DateTime birthdate,
      Gender gender) async {
    registerQueueDb.save(
      {
        "firstname": firstName,
        "middlename": middleName,
        "lastname": lastName,
        "suffix": suffix,
        "pin": pin,
        "birthDate": birthdayFormatter.format(birthdate),
        "gender": gender == Gender.male ? "male" : "female",
        "contactNumber": contactNumber,
        "address": userAddressMapper.toMap(userAddress),
      },
    );
    await restClient.otpMobileNumber(contactNumber);
  }

  @override
  Future<void> registerEstablishment(
    String establishmentName,
    String pin,
    String contactNumber,
    UserAddress userAddress,
  ) async {
    registerQueueDb.save(
      {
        "firstname": establishmentName,
        "pin": pin,
        "contactNumber": contactNumber,
        "address": userAddressMapper.toMap(userAddress),
      },
    );
    await restClient.otpMobileNumber(contactNumber);
  }

  @override
  Future<dynamic> getRegisterQueueData() async {
    return await registerQueueDb.getRegistrationData();
  }

  @override
  Future<void> verifyOtp(String otp) async {
    StandardResponse userInfoResponse;

    await restClient.verifyOtp(otp);

    Map<dynamic, dynamic> registrationData = await getRegisterQueueData();

    if (registrationData.length == 9) {
      userInfoResponse = await restClient.registerIndividual(
          RegisterIndividualRequest.fromJson(registrationData));
    } else if (registrationData.length == 4) {
      userInfoResponse = await restClient.registerEstablishment(
        RegisterEstablishmentRequest.fromJson(registrationData),
      );
    }

    await sessionDb.save({
      "user": userInfoResponse.data['user'],
      "token": userInfoResponse.data['token']
    });
  }

  @override
  Future<void> signIn(String contactNumber, String pin) async {
    StandardResponse response = await restClient.login(contactNumber, pin);
    await sessionDb.save({"token": response.data['token']});
  }

  Future<bool> verifyMobileNumber(String mobileNumber) async {
    final verificationResult =
        await restClient.verifyMobileNumber(mobileNumber);
    return verificationResult.data;
  }

  @override
  Future<void> resendOTP(String mobileNumber) async {
    await restClient.otpMobileNumber(mobileNumber);
  }
}
