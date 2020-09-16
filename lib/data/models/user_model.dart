import 'package:radar_qrcode_flutter/core/architecture/radar_app_architecture.dart';
import 'package:intl/intl.dart';
import 'package:radar_qrcode_flutter/core/utils/date_utils.dart';

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
  final String displayId;
  final String establishmentName;

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
    this.displayId,
    this.establishmentName,
  });

  String get fullName => "$firstName $lastName".toUpperCase();

  String birthDateToString(DateTime birthdate) {
    DateFormat birthdayFormatter = DateFormat("yyyy-MM-dd");
    return birthdayFormatter.format(birthdate);
  }

  int get age => birthDate != null ? DateUtils.calculateAge(birthDate) : null;
}
