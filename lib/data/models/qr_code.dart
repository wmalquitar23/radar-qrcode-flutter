import 'package:flutter/foundation.dart';
import 'package:radar_qrcode_flutter/core/architecture/freddy_app_architecture.dart';

class QRCode extends RadarModel {
  final int userID;
  final String firstName;
  final String middleName;
  final String lastName;
  final String address;
  final int age;
  final bool isVerified;

  QRCode({
    @required this.userID,
    @required this.firstName,
    this.middleName,
    @required this.lastName,
    @required this.address,
    @required this.age,
    @required this.isVerified,
  });
}