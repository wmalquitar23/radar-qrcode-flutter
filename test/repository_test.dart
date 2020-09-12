import 'dart:io' as io;

import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:radar_qrcode_flutter/core/architecture/radar_app_architecture.dart';
import 'package:radar_qrcode_flutter/core/enums/enums.dart';
import 'package:radar_qrcode_flutter/data/models/address/barangay_model.dart';
import 'package:radar_qrcode_flutter/data/models/address/city_model.dart';
import 'package:radar_qrcode_flutter/data/models/address/province_model.dart';
import 'package:radar_qrcode_flutter/data/models/session_model.dart';
import 'package:radar_qrcode_flutter/data/models/user_model.dart';
import 'package:radar_qrcode_flutter/data/repositories_impl/address_repository_impl.dart';
import 'package:radar_qrcode_flutter/data/repositories_impl/authentication_repository_impl.dart';
import 'package:radar_qrcode_flutter/data/repositories_impl/transactions_repository_impl.dart';
import 'package:radar_qrcode_flutter/domain/repositories/address_repository.dart';
import 'package:radar_qrcode_flutter/domain/repositories/authentication_repository.dart';

import 'package:intl/intl.dart';
import 'package:radar_qrcode_flutter/domain/repositories/transactions_repository.dart';
import 'test_data_instantiator.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  io.HttpOverrides.global = null;
  AuthenticationRepositoryImpl authenticationRepositoryImpl;
  TransactionsRepositoryImpl transactionsRepositoryImpl;
  Session session;

  setUp(() async {
    RadarDataInstantiator dataInstantiator = TestDataInstantiator();
    await dataInstantiator.init();
    authenticationRepositoryImpl = GetIt.I.get<AuthenticationRepository>();
    transactionsRepositoryImpl = GetIt.I.get<TransactionsRepository>();
  });

  tearDown(() async {
    await authenticationRepositoryImpl.logout();
    GetIt.I.reset();
  });

  test('SIGNUP user', () async {
    //GIVEN THAT
    var formatter = DateFormat('yyyyMMddmmss');
    var firstName = "Jesther${formatter.format(DateTime.now())}";
    var lastName = "Minor${formatter.format(DateTime.now())}";
    var middleName = "Min${formatter.format(DateTime.now())}";
    var pin = "1234";
    var contactNumber = "09359098175";
    var address = "Maniki, Kapalong, Davao del Norte";

    //WHEN
    await authenticationRepositoryImpl.registerIndividual(
      firstName,
      lastName,
      middleName,
      pin,
      contactNumber,
      address,
      DateTime.now(),
      Gender.male,
    );
    session = await authenticationRepositoryImpl.getCurrentSession();

    //THEN SHOULD EXPECT
    print(session.user);
    expect(session, isNotNull);
    expect(session.token, isNotNull);
  });

  test('SIGNUP establishment', () async {
    //GIVEN THAT
    var formatter = DateFormat('yyyyMMddmmss');
    var establishmentName = "Establishment${formatter.format(DateTime.now())}";
    var pin = "1234";
    var contactNumber = "9122226789"; // Assuming number is not yet registered
    var address = "Maniki, Kapalong, Davao del Norte";

    //WHEN
    await authenticationRepositoryImpl.registerEstablishment(
      establishmentName,
      pin,
      contactNumber,
      address,
    );

    await authenticationRepositoryImpl
        .verifyOtp("123456"); // Assuming OTP is Correct

    session = await authenticationRepositoryImpl.getCurrentSession();

    //THEN SHOULD EXPECT
    print(session);
    print(session.user);
    expect(session, isNotNull);
    expect(session.token, isNotNull);
  });

  test('Register Queue', () async {
    //GIVEN THAT
    var formatter = DateFormat('yyyyMMddmmss');
    var firstName = "Jesther${formatter.format(DateTime.now())}";
    var lastName = "Minor${formatter.format(DateTime.now())}";
    var middleName = "Min${formatter.format(DateTime.now())}";
    var pin = "1234";
    var contactNumber = "09359098175";
    var address = "Maniki, Kapalong, Davao del Norte";

    //WHEN
    await authenticationRepositoryImpl.registerIndividual(
      firstName,
      lastName,
      middleName,
      pin,
      contactNumber,
      address,
      DateTime.now(),
      Gender.male,
    );

    dynamic data = await authenticationRepositoryImpl.getRegisterQueueData();

    //THEN SHOULD EXPECT
    print(data);
    expect(data, isNotNull);
    expect(data, isNotNull);
  });

  test('getCurrentSession', () async {
    //GIVEN THAT LOGIN HAS BEEN PERFORMED

    //WHEN
    session = await authenticationRepositoryImpl.getCurrentSession();

    print(session.user.firstName);

    expect(session, isNotNull);
    expect(session.user, isNotNull);
  });

  group("verifyMobileNumer", () {
    test('Mobile number is already used', () async {
      //GIVEN THAT mobileNumber is alerady used
      final mobileNumber = "9452092915";

      //WHEN
      final vericationResult =
          await authenticationRepositoryImpl.verifyMobileNumber(mobileNumber);

      //THEN SHOULD EXPECT
      expect(vericationResult, isNotNull);
      expect(vericationResult, true);
    });

    test('Mobile number is not yet used', () async {
      //GIVEN THAT mobileNumber is not yet used
      final mobileNumber = "9664191171";

      //WHEN
      final vericationResult =
          await authenticationRepositoryImpl.verifyMobileNumber(mobileNumber);

      //THEN SHOULD EXPECT
      expect(vericationResult, isNotNull);
      expect(vericationResult, false);
    });
  });
  group("Transactions", () {
    test('Check in', () async {
      //GIVEN THAT mobileNumber is alerady used

      //WHEN
      await transactionsRepositoryImpl.checkIn(
          User(
            id: "5f54e91a59cfad1d8f00a491",
            displayId: "JM4988",
            firstName: "Jesther Jordan",
            lastName: "Minor",
            isVerified: false,
            profileImageUrl:
                "http://54.179.150.142:3000/api/v1/file/5f55abd259cfad1d8f00a495",
            address: "Maniki, Kapalong, Davao del Norte",
            birthDate: DateTime.now(),
          ),
          false);
    });
  });

  group("Address", () {
    AddressRepository addressRepository;

    test("Province", () async {
      //GIVEN THAT
      addressRepository = AddressRepositoryImpl();

      //WHEN
      List<Province> result = await addressRepository.getAllProvince();

      //THEN SHOULD EXPECT
      print(result[0].provCode);
      print(result[0].provDesc);
      expect(result, isNotNull);
      expect(result.length, isPositive);
    });

    test("City or Municipality", () async {
      //GIVEN THAT
      addressRepository = AddressRepositoryImpl();

      //WHEN
      List<City> result = await addressRepository.getAllCityOrMunicipality();

      //THEN SHOULD EXPECT
      print(result[0].citymunCode);
      print(result[0].citymunDesc);
      expect(result, isNotNull);
      expect(result.length, isPositive);
    });

    test("Barangay", () async {
      //GIVEN THAT
      addressRepository = AddressRepositoryImpl();

      //WHEN
      List<Barangay> result = await addressRepository.getAllBarangay();

      //THEN SHOULD EXPECT
      print(result[0].brgyCode);
      print(result[0].brgyDesc);
      expect(result, isNotNull);
      expect(result.length, isPositive);
    });
  });
}
