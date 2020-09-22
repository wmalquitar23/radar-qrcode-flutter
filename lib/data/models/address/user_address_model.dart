import 'package:radar_qrcode_flutter/core/architecture/radar_app_architecture.dart';

class UserAddress extends RadarModel {
  final String brgyCode;
  final String brgyName;
  final String citymunCode;
  final String citymunName;
  final String provCode;
  final String provName;
  final String streetHouseNo;

  UserAddress({
    this.brgyCode,
    this.brgyName,
    this.citymunCode,
    this.citymunName,
    this.provCode,
    this.provName,
    this.streetHouseNo,
  });
}
