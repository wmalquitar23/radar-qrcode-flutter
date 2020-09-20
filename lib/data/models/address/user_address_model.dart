import 'package:radar_qrcode_flutter/core/architecture/radar_app_architecture.dart';

class UserAddress extends RadarModel {
  final String brgyCode;
  final String citymunCode;
  final String provCode;
  final String streetHouseNo;

  UserAddress({
    this.brgyCode,
    this.citymunCode,
    this.provCode,
    this.streetHouseNo,
  });
}
