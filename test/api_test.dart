import 'dart:io' as io;

import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:radar_qrcode_flutter/core/architecture/freddy_app_architecture.dart';
import 'package:radar_qrcode_flutter/data/local_db/session_db.dart';
import 'package:radar_qrcode_flutter/data/mappers/user_mapper.dart';
import 'package:radar_qrcode_flutter/data/models/request/register_establishment_request.dart';
import 'package:radar_qrcode_flutter/data/models/standard_response.dart';
import 'package:radar_qrcode_flutter/data/models/user_model.dart';
import 'package:radar_qrcode_flutter/data/sources/data/rest_client.dart';

import 'package:intl/intl.dart';
import 'package:sembast/sembast.dart';
import 'test_data_instantiator.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  io.HttpOverrides.global = null;
  RestClient restClient;
  Database database;
  SessionDb sessionDb;
  Logger logger = Logger();

  Future<void> login() async {
    //GIVEN THAT
    var contactNumber = "9451096905";
    var pin = "4321";

    try {
      StandardResponse userInfoResponse =
          await restClient.login(contactNumber, pin);
      expect(userInfoResponse, isNotNull);
      expect(userInfoResponse.data, isNotNull);

      await sessionDb.save({
        "token": userInfoResponse.data['token'],
      });
    } catch (e) {
      logger.i(e);
    }
  }

  setUp(() async {
    RadarDataInstantiator dataInstantiator = TestDataInstantiator();
    await dataInstantiator.init();
    restClient = GetIt.I.get<RestClient>();
    database = GetIt.I.get<Database>();
    sessionDb = SessionDb(database);

    if (restClient.hasToken()) return;
    await login();
  });

  tearDown(() {
    GetIt.I.reset();
  });

  test('Signup Individual', () async {
    DateFormat birthdayFormatter = DateFormat("yyyy-MM-dd");
    //GIVEN THAT
    var formatter = DateFormat('yyyyMMddmmss');
    var firstName = "Jesther${formatter.format(DateTime.now())}";
    var lastName = "Minor${formatter.format(DateTime.now())}";
    var middleName = "Min${formatter.format(DateTime.now())}";
    var pin = "1234";
    var birthDate = birthdayFormatter.format(DateTime.utc(1995, 07, 31));
    var gender = "male";
    var contactNumber = "9452092915";
    var address = "Maniki, Kapalong, Davao del Norte";

    UserMapper mapper = UserMapper();

    dynamic data = mapper.toMap(
      User(
        firstName: firstName,
        lastName: lastName,
        middleName: middleName,
        pin: pin,
        gender: gender,
        birthDate: birthdayFormatter.parse(birthDate),
        contactNumber: contactNumber,
        address: address,
      ),
    );

    print(data);

    //WHEN
    StandardResponse response = await restClient.registerIndividual(data);

    //THEN SHOULD EXPECT
    print(response.data);
    expect(response, isNotNull);
    expect(response.data, isNotNull);
  });

  test('OTP Mobile number', () async {
    //GIVEN THAT
    var contactNumber = "9532110774";

    //WHEN
    StandardResponse response = await restClient.otpMobileNumber(contactNumber);

    //THEN SHOULD EXPECT
    print(response.data);
    expect(response, isNotNull);
    expect(response.data, isNotNull);
  });

  test('REGISTRATION establishment', () async {
    //GIVEN THAT
    var request = RegisterEstablishmentRequest(
        name: "Starbucks",
        pin: "1234",
        contactNumber: "+639664391877",
        address: Address(name: "Manila"));

    //WHEN
    StandardResponse response = await restClient.registerEstablishment(request);

    //THEN SHOULD EXPECT
    print(response.data);
    expect(response, isNotNull);
    expect(response.data, isNotNull);
  });

  test('RECORD checkin', () async {
    //GIVEN THAT
    var individualId = "5f45d38ba4d39a2cff051721";
    var establishmentId = "5f466249a4d39a2cff051727";

    //WHEN
    StandardResponse response =
        await restClient.checkin(individualId, establishmentId);

    //THEN SHOULD EXPECT
    print(response.data);
    expect(response, isNotNull);
    expect(response.data, isNotNull);
  });

  test('INDIVIDUAL getAllIndividuals', () async {
    //WHEN
    StandardResponse response = await restClient.getAllIndividuals();

    //THEN SHOULD EXPECT
    print(response.data);
    expect(response, isNotNull);
    expect(response.data, isNotNull);
  });

  test('INDIVIDUAL getAllIndividuals', () async {
    //WHEN
    StandardResponse response = await restClient.getAllEstablishments();

    //THEN SHOULD EXPECT
    print(response.data);
    expect(response, isNotNull);
    expect(response.data, isNotNull);
  });

  test('AUTHORIZATION login', () async {
    //GIVEN THAT
    var contactNumber = "09451096905";
    var pin = "1234";

    //WHEN
    StandardResponse response = await restClient.login(contactNumber, pin);

    //THEN SHOULD EXPECT
    print(response.data);
    expect(response, isNotNull);
    expect(response.data, isNotNull);
  });

  test('UPLOAD fileUpload', () async {
    //GIVEN THAT;
    final file = new io.File('test_resources/sample_image.jpeg');

    //WHEN
    StandardResponse response = await restClient.fileUpload(file);
    print(response.data['url']);

    //THEN SHOULD EXPECT
    print(response.data);
    expect(response, isNotNull);
    expect(response.data, isNotNull);
  });

  test('UPLOAD fileDownload', () async {
    //GIVEN THAT;
    final file = "5f462f22d7a0d3f73d7fa0dd";

    //WHEN
    StandardResponse response = await restClient.downloadfile(file);

    //THEN SHOULD EXPECT
    print(response.data);
    expect(response, isNotNull);
    expect(response.data, isNotNull);
  });

  group("VERIFICATION identify mobile number", () {
    test('Mobile number is already used', () async {
      //GIVEN THAT mobileNumber is alerady used
      final mobileNumber = "9452092915";

      //WHEN
      StandardResponse response =
          await restClient.verifyMobileNumber(mobileNumber);

      //THEN SHOULD EXPECT
      print(response.data);
      expect(response, isNotNull);
      expect(response.data, true);
    });

    test('Mobile number is not yet used', () async {
      //GIVEN THAT mobileNumber is not yet used
      final mobileNumber = "9664191171";

      //WHEN
      StandardResponse response =
          await restClient.verifyMobileNumber(mobileNumber);

      //THEN SHOULD EXPECT
      print(response.data);
      expect(response, isNotNull);
      expect(response.data, false);
    });
  });

  group("Profile", () {
    test('Get Profile', () async {
      //WHEN
      StandardResponse response = await restClient.getProfileInfo();

      //THEN SHOULD EXPECT
      print(response.data);
      expect(response.data, isNotNull);
    });
    test('Change PIN', () async {
      var oldPin = "1234";
      var newPin = "4321";
      var id = "5f5077c9ee967f6732725035";
      //WHEN
      StandardResponse response =
          await restClient.changePin(oldPin, newPin, id);

      //THEN SHOULD EXPECT
      print(response.data);
      expect(response.data, isNotNull);
    });
  });
}
