import 'package:radar_qrcode_flutter/core/architecture/freddy_app_architecture.dart';

class User extends RadarModel {
  final String id;
  final String firstName;
  final String lastName;
  final String middleName;
  final String pin;
  final DateTime birthDate;
  final String gender;
  final String contactNumber;
  final String address;
  final String role;
  final bool isVerified;
  final String profileImageUrl;

  User({
    this.id,
    this.firstName,
    this.lastName,
    this.gender,
    this.pin,
    this.middleName,
    this.birthDate,
    this.contactNumber,
    this.address,
    this.role,
    this.isVerified,
    this.profileImageUrl,
  });

  String get fullName => "$firstName $lastName";
}
