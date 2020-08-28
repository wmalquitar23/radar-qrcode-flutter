import 'package:radar_qrcode_flutter/core/architecture/freddy_app_architecture.dart';
import 'package:radar_qrcode_flutter/data/models/user_model.dart';
import 'package:intl/intl.dart';

class UserMapper extends RadarMapper<User> {
  DateFormat birthDateFormatter = DateFormat("yyyy-MM-dd");
  @override
  User fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    return User(
      id: map['_id'],
      firstName: map['first_name'],
      lastName: map['last_name'],
      middleName: map['middle_name'] != null ? map['middle_name'] : null,
      birthDate: map['birthDate'] != null
          ? birthDateFormatter.parse(map['birthDate'])
          : null,
      gender: map['gender'],
      contactNumber: map['contactNumber'],
      address: map['address']['name'],
      role: map['role'],
      isVerified: map['isVerified'],
    );
  }

  @override
  Map<String, dynamic> toMap(object) {
    return {
      "firstname": object.firstName,
      "lastname": object.lastName,
      "pin": object.pin,
      "birthDate": object.birthDate.toIso8601String(),
      "gender": object.gender,
      "contactNumber": object.contactNumber,
      "address": {"name": object.address},
    };
  }
}
