import 'package:radar_qrcode_flutter/core/architecture/freddy_app_architecture.dart';
import 'package:radar_qrcode_flutter/data/models/user_model.dart';
import 'package:intl/intl.dart';

class UserMapper extends RadarMapper<User> {
  DateFormat birthDateFormatter = DateFormat("yyyy-MM-dd");
  @override
  User fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    return User(
      firstName: map['first_name'],
      lastName: map['last_name'],
      middleName: map['middle_name'] != null ? map['middle_name'] : null,
      birthDate: map['birthDate'] != null
          ? birthDateFormatter.parse(map['birthDate'])
          : null,
      gender: map['gender'],
      contactNumber: map['contactNumber'],
      address: map['address']['name'],
    );
  }

  @override
  Map<String, dynamic> toMap(object) {
    return {
      "firstname": object.firstName,
      "lastname": object.firstName,
      "pin": object.firstName,
      "birthDate": object.firstName,
      "gender": object.firstName,
      "contactNumber": object.firstName,
      "address": object.firstName,
    };
  }
}
