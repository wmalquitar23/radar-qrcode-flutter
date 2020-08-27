import 'dart:io' as io;

import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:radar_qrcode_flutter/core/architecture/freddy_app_architecture.dart';
import 'package:radar_qrcode_flutter/core/enums/enums.dart';
import 'package:radar_qrcode_flutter/data/models/session_model.dart';
import 'package:radar_qrcode_flutter/data/repositories_impl/authentication_repository_impl.dart';
import 'package:radar_qrcode_flutter/domain/repositories/authentication_repository.dart';

import 'package:intl/intl.dart';
import 'test_data_instantiator.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  io.HttpOverrides.global = null;
  AuthenticationRepositoryImpl authenticationRepositoryImpl;
  Session session;

  setUp(() async {
    RadarDataInstantiator dataInstantiator = TestDataInstantiator();
    await dataInstantiator.init();
    authenticationRepositoryImpl = GetIt.I.get<AuthenticationRepository>();
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
}
