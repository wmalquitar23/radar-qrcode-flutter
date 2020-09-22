import 'dart:io' as io;

import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:radar_qrcode_flutter/core/architecture/radar_app_architecture.dart';
import 'package:radar_qrcode_flutter/core/enums/enums.dart';
import 'package:radar_qrcode_flutter/data/local_db/rapidpass_contact_db.dart';
import 'package:radar_qrcode_flutter/data/local_db/session_db.dart';
import 'package:radar_qrcode_flutter/data/models/address/user_address_model.dart';
import 'package:radar_qrcode_flutter/data/models/rapidpass_contact_model.dart';
import 'package:radar_qrcode_flutter/data/models/request/register_establishment_request.dart';
import 'package:radar_qrcode_flutter/data/models/request/register_individual_request.dart';
import 'package:radar_qrcode_flutter/data/models/standard_response.dart';
import 'package:radar_qrcode_flutter/data/sources/data/rest_client.dart';

import 'package:intl/intl.dart';
import 'package:radar_qrcode_flutter/data/sources/local_data/local_data_client.dart';
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
    var contactNumber = "96613912216";
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
    var gender = Gender.male;
    var contactNumber = "9452082819";

    var request = RegisterIndividualRequest(
      firstname: firstName,
      middlename: middleName,
      lastname: lastName,
      pin: pin,
      birthDate: birthdayFormatter.parse(birthDate).toString(),
      gender: gender,
      contactNumber: contactNumber,
      userAddress: UserAddress(
        streetHouseNo: "Test",
        brgyCode: "Test",
        brgyName: "Test",
        citymunCode: "Test",
        citymunName: "Test",
        provCode: "Test",
        provName: "Test",
      ),
    );

    print(request.toJson());

    //WHEN
    StandardResponse response = await restClient.registerIndividual(request);

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
      firstname: "Starbucks",
      pin: "1234",
      contactNumber: "+639664391037",
      userAddress: UserAddress(
        streetHouseNo: "Test",
        brgyCode: "Test",
        brgyName: "Test",
        citymunCode: "Test",
        citymunName: "Test",
        provCode: "Test",
        provName: "Test",
      ),
    );

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
  group("Transactions", () {
    test('CheckIn', () async {
      //GIVEN THAT
      String id = "5f53838759cfad1d8f00a477";
      //WHEN
      StandardResponse response = await restClient.checkIn(id);

      //THEN SHOULD EXPECT
      print(response.data);
      expect(response.data, isNotNull);
    });
  });

  group("Address", () {
    test("Province", () async {
      //GIVEN THAT
      LocalDataClient localDataClient = LocalDataClient();

      //WHEN
      Map<String, dynamic> result = await localDataClient.getProvince();

      //THEN SHOULD EXPECT
      print(result["RECORDS"]);
      expect(result, isNotNull);
    });

    test("City or Municipality", () async {
      //GIVEN THAT
      LocalDataClient localDataClient = LocalDataClient();

      //WHEN
      Map<String, dynamic> result =
          await localDataClient.getCityOrMunicipality();

      //THEN SHOULD EXPECT
      print(result);
      expect(result, isNotNull);
    });

    test("Barangay", () async {
      //GIVEN THAT
      LocalDataClient localDataClient = LocalDataClient();

      //WHEN
      Map<String, dynamic> result = await localDataClient.getBarangay();

      //THEN SHOULD EXPECT
      print(result);
      expect(result, isNotNull);
    });
  });

  group("Contact - Local DB", () {
    test("Invalid Data", () async {
      //GIVEN THAT
      RapidPassContactDb contactDb = RapidPassContactDb(database);

      //WHEN
      final result = await contactDb.getContact();

      //THEN SHOULD EXPECT
      print(result);
      expect(result, isNull);
    });

    test("Save and Get", () async {
      //GIVEN THAT
      RapidPassContactDb contactDb = RapidPassContactDb(database);
      final mNumber = "09087863725";
      final emailAddr = "test@gmail.com";

      //WHEN
      await contactDb.saveContact(RapidPassContact(
        mobileNumber: mNumber,
        emailAddress: emailAddr,
      ));
      final result = await contactDb.getContact();

      //THEN SHOULD EXPECT
      print(result);
      print(result.mobileNumber);
      print(result.emailAddress);
      expect(result.mobileNumber, mNumber);
      expect(result.emailAddress, emailAddr);
    });

    test("Update", () async {
      //GIVEN THAT
      RapidPassContactDb contactDb = RapidPassContactDb(database);
      final mNumber = "09087863725";
      final emailAddr = "test@gmail.com";

      final mNumberNew = "09999999999";
      final emailAddrNew = "new_test@gmail.com";

      await contactDb.saveContact(RapidPassContact(
        mobileNumber: mNumber,
        emailAddress: emailAddr,
      ));

      //WHEN
      final result = await contactDb.updateContact(RapidPassContact(
        mobileNumber: mNumberNew,
        emailAddress: emailAddrNew,
      ));

      //THEN SHOULD EXPECT
      print(result);
      print(result.mobileNumber);
      print(result.emailAddress);
      expect(result.mobileNumber, mNumberNew);
      expect(result.emailAddress, emailAddrNew);
    });
  });
}
