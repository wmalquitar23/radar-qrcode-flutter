import 'package:radar_qrcode_flutter/core/architecture/freddy_app_architecture.dart';

class User extends RadarModel {
  final String id;
  final String firstName;
  final String lastName;
  final String middleName;
  final String isVerified;
  final String contactNumber;

  User(
      {this.id,
      this.firstName,
      this.lastName,
      this.middleName,
      this.isVerified,
      this.contactNumber});

  String get fullName => "$firstName $lastName";
}
