import 'package:radar_qrcode_flutter/core/architecture/radar_app_architecture.dart';

class Verification extends RadarModel {
  final bool isVerified;
  final DateTime date;
  final expirationDate;

  Verification({
    this.isVerified,
    this.date,
    this.expirationDate,
  });
}
