import 'dart:io' as io;

import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:radar_qrcode_flutter/core/architecture/freddy_app_architecture.dart';
import 'package:radar_qrcode_flutter/data/models/standard_response.dart';
import 'package:radar_qrcode_flutter/data/sources/data/rest_client.dart';

// import 'package:intl/intl.dart';
import 'test_data_instantiator.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  io.HttpOverrides.global = null;
  RestClient restClient;

  setUp(() async {
    RadarDataInstantiator dataInstantiator = TestDataInstantiator();
    await dataInstantiator.init();
    restClient = GetIt.I.get<RestClient>();
  });

  tearDown(() {
    GetIt.I.reset();
  });

  test('Signup Individual', () async {
    // var bdayFormatter = DateFormat('yyyy-MM-dd');
    //GIVEN THAT
    // var formatter = DateFormat('yyyyMMddmmss');
    // var firstName = "Jesther${formatter.format(DateTime.now())}";
    // var lastName = "Minor${formatter.format(DateTime.now())}";
    // var middleName = "Min${formatter.format(DateTime.now())}";
    // var pin = "1234";
    // var birthDate = bdayFormatter.format(DateTime.utc(1995, 07, 31));
    // var gender = "male";
    // var contactNumber = "09452092915";
    // var address = "Maniki, Kapalong, Davao del Norte";

    //WHEN
    // StandardResponse response = await restClient.registerIndividual(
    //   firstName,
    //   lastName,
    //   middleName,
    //   pin,
    //   contactNumber,
    //   address,
    //   birthDate,
    //   gender,
    // );

    //THEN SHOULD EXPECT
    // print(response.data);
    // expect(response, isNotNull);
    // expect(response.data, isNotNull);
  });

  test('OTP Mobile number', () async {
    //GIVEN THAT
    var contactNumber = "09532110774";

    //WHEN
    StandardResponse response = await restClient.otpMobileNumber(contactNumber);

    //THEN SHOULD EXPECT
    print(response.data);
    expect(response, isNotNull);
    expect(response.data, isNotNull);
  });
}
