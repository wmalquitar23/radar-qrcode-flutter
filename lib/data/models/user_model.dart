import 'package:enum_to_string/enum_to_string.dart';
import 'package:radar_qrcode_flutter/core/architecture/radar_app_architecture.dart';
import 'package:intl/intl.dart';
import 'package:radar_qrcode_flutter/core/enums/enums.dart';
import 'package:radar_qrcode_flutter/core/utils/app/env_util.dart';
import 'package:radar_qrcode_flutter/core/utils/date_utils.dart';
import 'package:radar_qrcode_flutter/data/models/address/user_address_model.dart';
import 'package:radar_qrcode_flutter/data/models/requirement.dart';

class User extends RadarModel {
  final String id;
  final String firstName;
  final String lastName;
  final String middleName;
  final String suffix;
  final String pin;
  final DateTime birthDate;
  final Gender gender;
  final String contactNumber;
  final UserAddress address;
  final String role;
  final bool isVerified;
  final String profileImageUrl;
  final String displayId;
  final String establishmentName;
  final Requirement requirement;

  User({
    this.id,
    this.firstName,
    this.lastName,
    this.suffix,
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
    this.requirement,
  });

  String get fullName =>
      "$firstName ${middleName.length > 0 ? middleName[0] + ". " : ""}$lastName${suffix.length > 0 ? ", " + suffix : ""}"
          .toUpperCase();

  Future<String> imageFormat(String imageId) async {
    Map<String, String> env = await loadEnvFile();

    return env['API_URL'] + "/files/" + imageId;
  }

  String birthDateToString(DateTime birthdate) {
    DateFormat birthdayFormatter = DateFormat("yyyy-MM-dd");
    return birthdate != null ? birthdayFormatter.format(birthdate) : null;
  }

  int get age => birthDate != null ? DateUtils.calculateAge(birthDate) : null;

  String get genderToString => gender == Gender.male
      ? EnumToString.convertToString(Gender.male, camelCase: true)
      : EnumToString.convertToString(Gender.female, camelCase: true);
}
