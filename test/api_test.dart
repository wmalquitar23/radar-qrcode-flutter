import 'dart:io' as io;

import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:radar_qrcode_flutter/core/architecture/freddy_app_architecture.dart';
import 'package:radar_qrcode_flutter/data/models/standard_response.dart';
import 'package:radar_qrcode_flutter/data/sources/data/rest_client.dart';

import 'package:intl/intl.dart';
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

  test('SIGNUP user', () async {
    //GIVEN THAT
    var formatter = DateFormat('yyyyMMddmmss');
    var firstName = "Jesther${formatter.format(DateTime.now())}";
    var lastName = "Minor${formatter.format(DateTime.now())}";
    var pin = "1234";
    var contactNumber = "09451096905";
    var address = "Maniki, Kapalong, Davao del Norte";

    //WHEN
    StandardResponse response = await restClient.register(
        firstName, lastName, pin, contactNumber, address);

    //THEN SHOULD EXPECT
    print(response.data);
    expect(response, isNotNull);
    expect(response.data, isNotNull);
  });
}
